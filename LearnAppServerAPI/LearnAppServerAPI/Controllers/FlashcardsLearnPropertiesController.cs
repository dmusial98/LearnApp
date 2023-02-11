using AutoMapper;
using CoreLearnAppServerAPI.Data;
using LearnAppServerAPI.Data.Entities;
using LearnAppServerAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System;

namespace LearnAppServerAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FlashcardsLearnPropertiesController: ControllerBase
    {
        private readonly ILearnAppServerAPIRepository _repository;
        private readonly IMapper _mapper;
        private readonly LinkGenerator _linkGenerator;

        public FlashcardsLearnPropertiesController(ILearnAppServerAPIRepository repository, IMapper mapper, LinkGenerator linkGenerator)
        {
            _repository = repository;
            _mapper = mapper;
            _linkGenerator = linkGenerator;
        }

        [HttpGet]
        public async Task<ActionResult<FlashcardLearnPropertiesModel[]>> Get()
        {
            try
            {
                var result = await _repository.GetAllFlashcardLearnPropertiesAsync();

                if (result is not null && result.Length > 0)
                {
                    return _mapper.Map<FlashcardLearnPropertiesModel[]>(result);
                }
                else
                    return NotFound();
            }
            catch (Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<FlashcardLearnPropertiesModel>> Get(int id, bool withFlashcard = false, bool withStudent = false)
        {
            try
            {
                var result = await _repository.GetFlashcardLearnPropertiesByIdAsync(id, withFlashcard, withStudent);
                 
                if (result == null)
                    return NotFound();

                return _mapper.Map<FlashcardLearnPropertiesModel>(result);
            }
            catch (Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpGet]
        [Route("byFlashcardAndStudent")]
        public async Task<ActionResult<FlashcardLearnPropertiesModel>> Get(int flashcardId, int studentId)
        {
            try
            {
                var result = await _repository.GetFlashcardLearnPropertiesByFlashcardIdAndStudentId(flashcardId, studentId, true, true);

                if (result is null)
                    return NotFound();
                else
                    return _mapper.Map<FlashcardLearnPropertiesModel>(result);
            }
            catch(Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpPost]
        public async Task<ActionResult<FlashcardLearnPropertiesModel>> Post(FlashcardLearnPropertiesModel[] models)
        {
            try
            {
                List<FlashcardLearnProperties> flashcards = new List<FlashcardLearnProperties>();

                foreach (var model in models)
                {
                    if (model.FlashcardId == 0 || model.StudentId == 0 ||
                        await _repository.GetFlashcardLearnPropertiesByFlashcardIdAndStudentId(
                            model.FlashcardId, model.StudentId, withFlashcard: false, withStudent: false) != null)
                        continue;

                    var flashcard = _mapper.Map<FlashcardLearnProperties>(model);                    
                    _repository.Add(flashcard);
                    flashcards.Add(flashcard);
                }

                if (await _repository.SaveChangesAsync())
                {
                    List<FlashcardLearnProperties> result = new List<FlashcardLearnProperties>();
                    foreach (var flashcard in flashcards)
                        result.Add(_mapper.Map<FlashcardLearnProperties>(flashcard));

                    return Created($"/api/flashcardsLearnProperties/{result[0].Id}", result);
                }
            }
            catch (Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }

            return BadRequest();
        }

        [HttpPut("{id:int}")]
        public async Task<ActionResult<FlashcardLearnPropertiesModel>> Put(int id, FlashcardLearnPropertiesModel model)
        {
            try
            {
                var oldFlashcard = await _repository.GetFlashcardLearnPropertiesByIdAsync(id, withFlashcard: false, withStudent: false);
                if (oldFlashcard == null)
                    return NotFound($"Could not find flashcard learn properties with id equal {id}");

                if(IsReferenceToDifferentFlashcardLearnProperties(oldFlashcard, model))
                    return BadRequest("Couldn't change flashcard id or student id");

                if (CompareFlashcardLearnPropertiesAndFlashcardLearnPropertiesModel(oldFlashcard, model))
                    return _mapper.Map<FlashcardLearnPropertiesModel>(oldFlashcard);

                _mapper.Map(model, oldFlashcard);
                oldFlashcard.Id = id;

                if (await _repository.SaveChangesAsync())
                    return _mapper.Map<FlashcardLearnPropertiesModel>(oldFlashcard);

            }
            catch (Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }

            return BadRequest();
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                var oldFlashcard = await _repository.GetFlashcardLearnPropertiesByIdAsync(id, withFlashcard: false, withStudent: false);
                if (oldFlashcard == null) return NotFound($"Could not find flashcard learn properties with id equal {id}");

                _repository.Delete(oldFlashcard);

                if (await _repository.SaveChangesAsync())
                    return Ok();
            }
            catch (Exception exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{exception.Message}");
            }

            return BadRequest();
        }

        private bool CompareFlashcardLearnPropertiesAndFlashcardLearnPropertiesModel(FlashcardLearnProperties flashcard, FlashcardLearnPropertiesModel model)
        {
            if (flashcard == null || model == null)
                return true;

            if (flashcard.FlashcardId != model.FlashcardId)
                return false;
            if (flashcard.StudentId != model.StudentId)
                return false;
            if (flashcard.IsFavourite != model.IsFavourite)
                return false;
            if(flashcard.ProgressFlashcard  != model.ProgressFlashcard)
                return false;
            if (flashcard.ProgressABCDTest != model.ProgressABCDTest)
                return false;
            if (flashcard.ProgressTypeText != model.ProgressTypeText)
                return false;

            return true;
        }

        private bool IsReferenceToDifferentFlashcardLearnProperties(FlashcardLearnProperties flashcard, FlashcardLearnPropertiesModel model)
        {
            if (model == null) 
                return false;

            if (flashcard.StudentId != model.StudentId)
                return true;
            if (flashcard.FlashcardId != model.FlashcardId)
                return true;

            return false;
        }

    }

    
}
