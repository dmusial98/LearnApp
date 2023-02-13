using AutoMapper;
using CoreLearnAppServerAPI.Data;
using LearnAppServerAPI.Data.Entities;
using LearnAppServerAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;

namespace LearnAppServerAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FlashcardsSetsController : ControllerBase
    {
        private readonly ILearnAppServerAPIRepository _repository;
        private readonly IMapper _mapper;
        private readonly LinkGenerator _linkGenerator;

        public FlashcardsSetsController(ILearnAppServerAPIRepository repository, IMapper mapper, LinkGenerator linkGenerator)
        {
            _repository = repository;
            _mapper = mapper;
            _linkGenerator = linkGenerator;
        }

        [HttpGet]
        public async Task<ActionResult<FlashcardsSetModel[]>> Get(bool withPrivateSets = false)
        {
            try
            {
                var result = await _repository.GetAllFlashcardsSetsAsync(withPrivateSets);

                if (result is not null && result.Length != 0)
                    return _mapper.Map<FlashcardsSetModel[]>(result);
                else
                    return NotFound();

            }
            catch (Exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<FlashcardsSetModel>> Get(int id, bool withFlashcards = false, bool withEditor = false)
        {
            try
            {
                var result = await _repository.GetFlashcardsSetByIdAsync(id, withFlashcards, withEditor);

                if (result is not null)
                    return _mapper.Map<FlashcardsSetModel>(result);
                else
                    return NotFound();

            }
            catch (Exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpGet]
        [Route("byEditor")]
        public async Task<ActionResult<FlashcardsSetModel>> Get(int editorId)
        {
            try
            {
                var result = await _repository.GetFlashcardsSetByEditor(editorId, withFlashcards: true, withEditor: false);
                
                if(result is null)
                    return NotFound();

                return _mapper.Map<FlashcardsSetModel>(result);
            }
            catch (Exception ex) 
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }


        [HttpPost]
        public async Task<ActionResult<FlashcardsSetModel>> Post(FlashcardsSetModel model)
        {

            model.IsPublic= true;

            try
            {
                var flashcardsSet = _mapper.Map<FlashcardsSet>(model);
                _repository.Add(flashcardsSet);

                if (await _repository.SaveChangesAsync())
                    return Created($"/api/flashcardssets", _mapper.Map<FlashcardsSetModel>(flashcardsSet));
                
            }
            catch (Exception ex)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{ex.Message}");
            }

            return BadRequest();
        }

        [HttpPut("{id:int}")]
        public async Task<ActionResult<FlashcardsSetModel>> Put(int id, FlashcardsSetModel model)
        {
            try
            {
                var oldFlashcardsSet = await _repository.GetFlashcardsSetByIdAsync(id, withFlashcards: false, withEditor: false);
                if (oldFlashcardsSet == null)
                    return NotFound($"Could not find flashcards set with id equal {id}");

                if (CompareFlashcardsSetAndFlashcardsSetModel(oldFlashcardsSet, model))
                    return _mapper.Map<FlashcardsSetModel>(oldFlashcardsSet);

                _mapper.Map(model, oldFlashcardsSet);
                oldFlashcardsSet.Id = id;

                if (await _repository.SaveChangesAsync())
                    return _mapper.Map<FlashcardsSetModel>(oldFlashcardsSet);

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
                var oldFlashcardsSet = await _repository.GetFlashcardsSetByIdAsync(id, withFlashcards: false, withEditor: false);
                if (oldFlashcardsSet == null) return NotFound($"Could not find flashcard with id equal {id}");

                _repository.Delete(oldFlashcardsSet);

                if (await _repository.SaveChangesAsync())
                    return Ok();
            }
            catch (Exception exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{exception.Message}");
            }

            return BadRequest();
        }

        private bool CompareFlashcardsSetAndFlashcardsSetModel(FlashcardsSet flashcardsSet, FlashcardsSetModel model)
        {
            if (flashcardsSet == null || model == null)
                return true;

            if (flashcardsSet.EditorId != model.EditorId)
                return false;
            if (flashcardsSet.Name != model.Name)
                return false;
            if (flashcardsSet.Description != model.Description)
                return false;
            if(flashcardsSet.Date != model.Date)
                return false;

            return true;
        }
    }
}
