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
    public class FlashcardsController : ControllerBase
    {
        private readonly ILearnAppServerAPIRepository _repository;
        private readonly IMapper _mapper;
        private readonly LinkGenerator _linkGenerator;

        public FlashcardsController(ILearnAppServerAPIRepository repository, IMapper mapper, LinkGenerator linkGenerator)
        {
            _repository = repository;
            _mapper = mapper;
            _linkGenerator = linkGenerator;
        }

        [HttpGet]
        public async Task<ActionResult<FlashcardModel[]>> Get()
        {
            try
            {
                var result = await _repository.GetAllFlashcardsAsync();

                if (result is not null && result.Length > 0)
                {
                    return _mapper.Map<FlashcardModel[]>(result);
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
        public async Task<ActionResult<FlashcardModel>> Get(int id)
        {
            try
            {
                var result = await _repository.GetFlashcardByIdAsync(id);

                if(result == null)
                    return NotFound();

                return _mapper.Map<FlashcardModel>(result);
            }
            catch (Exception ex) 
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpPost]
        public async Task<ActionResult<FlashcardModel[]>> Post(FlashcardModel[] models)
        {
            try
            {
                List<Flashcard> flashcards = new List<Flashcard>();

                foreach (var model in models)
                {
                    var flashcard = _mapper.Map<Flashcard>(model);
                    _repository.Add(flashcard);
                    flashcards.Add(flashcard);
                }

                if (await _repository.SaveChangesAsync())
                {
                    List<FlashcardModel> result = new List<FlashcardModel>();
                    foreach (var flashcard in flashcards)
                        result.Add(_mapper.Map<FlashcardModel>(flashcard));

                    return Created($"/api/flashcards", result);
                }
            }
            catch(Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }

            return BadRequest();
        }

        [HttpPut("{id:int}")]
        public async Task<ActionResult<FlashcardModel>> Put(int id, FlashcardModel model)
        {
            try
            {
                var oldFlashcard = await _repository.GetFlashcardByIdAsync(id);
                if(oldFlashcard == null) 
                    return NotFound($"Could not find flashcard with id equal {id}");

                if(CompareFlashcardAndFlashcardModel(oldFlashcard, model))
                    return _mapper.Map<FlashcardModel>(oldFlashcard);

                _mapper.Map(model, oldFlashcard);
                oldFlashcard.Id = id;

                if (await _repository.SaveChangesAsync())
                    return _mapper.Map<FlashcardModel>(oldFlashcard);

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
                var oldFlashcard = await _repository.GetFlashcardByIdAsync(id);
                if (oldFlashcard == null) return NotFound($"Could not find flashcard with id equal {id}");

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

        private bool CompareFlashcardAndFlashcardModel(Flashcard flashcard, FlashcardModel model)
        {
            if (flashcard == null || model == null)
                return true;

            if (flashcard.Front != model.Front)
                return false;
            if (flashcard.Back != model.Back)
                return false;
            if (flashcard.FlashcardsSetId != model.FlashcardsSetId)
                return false;
            
            return true;
        }
    }
}
