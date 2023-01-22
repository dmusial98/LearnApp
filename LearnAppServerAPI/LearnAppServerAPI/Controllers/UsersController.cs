using Microsoft.AspNetCore.Mvc;
using AutoMapper;
using CoreLearnAppServerAPI.Data;
using LearnAppServerAPI.Data.Entities;
using LearnAppServerAPI.Models;

namespace LearnAppServerAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly ILearnAppServerAPIRepository _repository;
        private readonly IMapper _mapper;
        private readonly LinkGenerator _linkGenerator;

        public UsersController(ILearnAppServerAPIRepository repository, IMapper mapper, LinkGenerator linkGenerator)
        {
            _repository = repository;
            _mapper = mapper;
            _linkGenerator = linkGenerator;
        }


        [HttpGet]
        public async Task<ActionResult<UserModel[]>> Get()
        {
            try
            {
                var result = await _repository.GetAllUsersAsync();
                return _mapper.Map<UserModel[]>(result);
            }
            catch (Exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<UserModel>> Get(int id)
        {
            try
            {
                var result = await _repository.GetUserByIdAsync(id);
                Console.WriteLine($"{result.Id} {result.IsAdmin} {result.Email} {result.Password} {result.PhoneNumber} {result.FacebookLink} {result.TwitterLink} {result.AboutMe}");
                return _mapper.Map<UserModel>(result);
            }
            catch (Exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }
        }

        [HttpGet]
        [Route("byPassword")]
        public async Task<ActionResult<UserModel>> Get(string email, string password)
        {
            Console.WriteLine($"User byPassword {email} {password}");

            email = email.Replace("%40", "@");

            try
            {
                var result = await _repository.GetUserByEmailAndPasswordAsync(email, password);
                return _mapper.Map<UserModel>(result);
            }
            catch (Exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, "Database Failure");
            }

        }

        [HttpPost]
        public async Task<ActionResult<UserModel>> Post(UserModel model)
        {
            try
            {
                var user = _mapper.Map<User>(model);
                var user1 = await _repository.GetUserByEmailAsync(user.Email);
                if (user1 != null)
                    return this.StatusCode(StatusCodes.Status409Conflict, $"in databse user with the same email {user.Email} exists");

                _repository.Add(user);
                if (await _repository.SaveChangesAsync())
                {
                    return Created($"/api/users/{user.Id}", _mapper.Map<UserModel>(user));
                }
            }
            catch (Exception exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{exception.Message}");
            }

            return BadRequest();
        }

        [HttpPut("{id:int}")]
        public async Task<ActionResult<UserModel>> Put(int id, UserModel model)
        {
            try
            {
                var oldUser = await _repository.GetUserByIdAsync(id);
                if (oldUser == null) return NotFound($"Could not find user with id equal {id}");

                if (CompareUserAndUserModel(oldUser, model))
                    return _mapper.Map<UserModel>(oldUser);

                _mapper.Map(model, oldUser);
                oldUser.Id = id;

                if (await _repository.SaveChangesAsync())
                    return _mapper.Map<UserModel>(oldUser);
            }
            catch (Exception exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{exception.Message}");
            }

            return BadRequest();
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                var oldUser = await _repository.GetUserByIdAsync(id);
                if (oldUser == null) return NotFound($"Could not find user with id equal {id}");

                _repository.Delete(oldUser);

                if (await _repository.SaveChangesAsync())
                    return Ok();
            }
            catch (Exception exception)
            {
                return this.StatusCode(StatusCodes.Status500InternalServerError, $"{exception.Message}");
            }

            return BadRequest();
        }
        private bool CompareUserAndUserModel(User user, UserModel model)
        {
            if (user == null || model == null)
                return true;

            if (user.IsAdmin != model.IsAdmin)
                return false;
            if (user.Email != model.Email)
                return false;
            if (user.Password != model.Password)
                return false;
            if (user.PhoneNumber != model.PhoneNumber)
                return false;
            if (user.FacebookLink != model.FacebookLink)
                return false;
            if (user.TwitterLink != model.TwitterLink)
                return false;
            if (user.AboutMe != model.AboutMe) 
                return false;

            return true;
        }
    }
}
