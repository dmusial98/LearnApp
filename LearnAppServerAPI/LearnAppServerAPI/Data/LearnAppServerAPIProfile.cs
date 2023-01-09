using AutoMapper;
using LearnAppServerAPI.Data.Entities;
using LearnAppServerAPI.Models;

namespace LearnAppServerAPI.Data
{
    public class LearnAppServerAPIProfile : Profile
    {
        public LearnAppServerAPIProfile()
        {
            this.CreateMap<User, UserModel>()
                .ReverseMap();
        }
    }
}
