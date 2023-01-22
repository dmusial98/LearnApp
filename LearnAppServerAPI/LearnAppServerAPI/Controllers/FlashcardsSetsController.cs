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
        public async Task<ActionResult<FlashcardsSetModel[]>> Get()
        {
            try
            {
                var result = await _repository.GetAllFlashcardsSetsAsync();

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

        [HttpGet("{id}")]
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

        //public async Task<ActionResult<FlashcardsSetModel>> Get()
        //{

        //}
    }
}
