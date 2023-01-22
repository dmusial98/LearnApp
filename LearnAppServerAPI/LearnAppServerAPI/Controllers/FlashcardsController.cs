using AutoMapper;
using CoreLearnAppServerAPI.Data;
using LearnAppServerAPI.Data.Entities;
using LearnAppServerAPI.Models;
using Microsoft.AspNetCore.Mvc;

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

        


        // POST api/<FlashcardsController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<FlashcardsController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<FlashcardsController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
