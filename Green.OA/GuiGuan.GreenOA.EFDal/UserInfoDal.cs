using System.Data.Entity;
using GuiGuan.GreenOA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuiGuan.GreenOA.EFDal
{
    /// <summary>
    /// 封装 对UserInfo表的CRUD
    /// </summary>
    public class UserInfoDal
    {

        DataModelContainer db = new DataModelContainer();
        #region Query查询的
        public UserInfo GetUserInfoById(int id)
        {
            //return db.UserInfo.Find(id);
            return this.LoadUsers(u => u.Id == id).FirstOrDefault();
        }

        public List<UserInfo> GetAllUsers()
        {
            return this.LoadUsers(u => true).ToList();
            //return db.UserInfo.ToList();
        }

        public IQueryable<UserInfo> LoadUsers(Func<UserInfo, bool> whereLambda)
        {
            return db.UserInfo.Where(whereLambda).AsQueryable();

        }

        //TKEY:方法泛型
        public IQueryable<UserInfo> LoadPageUsers<TKey>(int pageSize, int pageIndex, out int total,
            Func<UserInfo, bool> whereLambda, Func<UserInfo, TKey> orderbyLambda, bool isAsc)
        {
            total = db.UserInfo.Where(whereLambda).Count();
            if (isAsc)
            {
                var temp = db.UserInfo.Where(whereLambda).OrderBy<UserInfo, TKey>(orderbyLambda).Skip(pageSize * (pageIndex - 1));
                return temp.AsQueryable();
            }
            else
            {
                var temp = db.UserInfo.Where(whereLambda).OrderByDescending<UserInfo, TKey>(orderbyLambda).Skip(pageSize * (pageIndex - 1));
                return temp.AsQueryable();
            }
        }

        #endregion

        #region CUD
        //批量添加
        public int Add(List<UserInfo> userList)
        {
            if (userList.Count <= 100)
            {
                foreach (var userInfo in userList)
                {
                    db.UserInfo.Add(userInfo);
                }
                return db.SaveChanges();
            }
            else
            {
                int total = 0;
                for (int i = 0; i < userList.Count; i++)
                {
                    db.UserInfo.Add(userList[i]);
                    if (i%20 == 0)
                    {
                        db.SaveChanges();
                    }
                }
                total+= db.SaveChanges();
                return total;
            }
        }

        //为什么返回对象本身：自动增长的主键，添加到数据库中去之后，自动将id赋值给在的实体对象。
        public UserInfo Add(UserInfo userInfo)
        {
            db.UserInfo.Add(userInfo);
            db.SaveChanges();
            return userInfo;
        }

        public bool Update(UserInfo userInfo)
        {
            db.Entry<UserInfo>(userInfo).State = EntityState.Modified;
            return db.SaveChanges() > 0;
        }

        public bool Delete(int id)
        {
            var userInfo = new UserInfo() { Id = id};
            userInfo.UName = "";
            db.Entry<UserInfo>(userInfo).State = EntityState.Modified;
            return db.SaveChanges() > 0;
        }
        public bool Delete(UserInfo userInfo)
        {
            db.Entry<UserInfo>(userInfo).State = EntityState.Modified;
            return db.SaveChanges() > 0;
        }
        #endregion
    }
}
