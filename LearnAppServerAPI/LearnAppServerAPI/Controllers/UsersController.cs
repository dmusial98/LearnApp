using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using CoreLearnAppServerAPI.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Routing;
using LearnAppServerAPI.Data.Entities;
using LearnAppServerAPI.Models;
using AutoMapper.Configuration.Conventions;

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
                var newUser = new User();
                _mapper.Map(model, newUser);
                
                if (oldUser == null) 
                    return NotFound($"Could not find user with id equal {id}");

                if (!ValidateUserToEdit(newUser))
                    return BadRequest($"Can't edit user with empty email or password field");

                ReplaceUserFields(oldUser, newUser);
                newUser.Id = id;
                CopyUserFields(oldUser, newUser);

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

        private bool ValidateUserToEdit(User user)
        {
            if(String.IsNullOrEmpty(user.Email)) 
                return false;
            if(String.IsNullOrEmpty(user.Password))
                return false;

            return true;
        }

        private void ReplaceUserFields(User oldUser, User newUser)
        {
            if(oldUser == null) return;
            if(newUser == null) return;

            if (newUser.PhoneNumber == null)
                if (!String.IsNullOrEmpty(oldUser.PhoneNumber))
                    newUser.PhoneNumber = oldUser.PhoneNumber;
                else
                    newUser.PhoneNumber = string.Empty;

            if (newUser.FacebookLink == null)
                if (!String.IsNullOrEmpty(oldUser.FacebookLink))
                    newUser.FacebookLink = oldUser.FacebookLink;
                else
                    newUser.FacebookLink = string.Empty;

            if (newUser.TwitterLink == null)
                if (!String.IsNullOrEmpty(oldUser.TwitterLink))
                    newUser.TwitterLink = oldUser.TwitterLink;
                else
                    newUser.TwitterLink = string.Empty;

            if (newUser.AboutMe == null)
                if (!String.IsNullOrEmpty(oldUser.AboutMe))
                    newUser.AboutMe = oldUser.AboutMe;
                else
                    newUser.AboutMe = string.Empty;

            return;            
        }

        private void CopyUserFields(User oldUser, User newUser)
        {
            if(oldUser == null|| newUser == null) 
                return;

            oldUser.Id= newUser.Id;
            oldUser.IsAdmin = newUser.IsAdmin;
            oldUser.Email = newUser.Email;

            oldUser.Password = newUser.Password;
            oldUser.PhoneNumber = newUser.PhoneNumber;
            oldUser.FacebookLink = newUser.FacebookLink;
            oldUser.TwitterLink = newUser.TwitterLink;
            oldUser.AboutMe = newUser.AboutMe;

            return;
        }
    }
}
