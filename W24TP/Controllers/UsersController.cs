using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using W24TP.Models;

namespace W24TP.Controllers
{
    public class UsersController : Controller
    {
        private ForumONIEntities db = new ForumONIEntities();

        private static DateTime Max(DateTime first, DateTime second)
        {
            return first > second ? first : second;
        }

        // GET: Users
        public ActionResult Index()
        {
            return View(db.AspNetUsers.Select(yousir => new UserDisplay
            {
                UserID = yousir.Id,
                UserName = yousir.UserName,
                NbrSub = db.Messages.Count(t => t.UserID == yousir.Id),
                NbrRep = db.Reponses.Count(t => t.UserID == yousir.Id),
                LastDate = db.Messages
                    .Where(t => t.UserID == yousir.Id)
                    .Select(t => t.CreationDate)
                    .Union(db.Reponses
                        .Where(t => t.UserID == yousir.Id)
                        .Select(t => t.CreationDate))
                    .OrderByDescending(t => t)
                    .FirstOrDefault()
            }));
        }

        // GET: Users/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            AspNetUser yousir = db.AspNetUsers.Find(id);
            if (yousir == null)
            {
                return HttpNotFound();
            }

            return View(new UserDisplay
            {
                UserID = yousir.Id,
                UserName = yousir.UserName,
                NbrSub = db.Messages.Count(t => t.UserID == yousir.Id),
                NbrRep = db.Reponses.Count(t => t.UserID == yousir.Id),
                LastDate = db.Messages
                    .Where(t => t.UserID == yousir.Id)
                    .Select(t => t.CreationDate)
                    .Union(db.Reponses
                        .Where(t => t.UserID == yousir.Id)
                        .Select(t => t.CreationDate))
                    .OrderByDescending(t => t)
                    .FirstOrDefault()
            });
        }

        // GET: Users/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include =
                "Id,Email,EmailConfirmed,PasswordHash,SecurityStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEndDateUtc,LockoutEnabled,AccessFailedCount,UserName")]
            AspNetUser aspNetUser)
        {
            if (ModelState.IsValid)
            {
                db.AspNetUsers.Add(aspNetUser);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(aspNetUser);
        }

        // GET: Users/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            AspNetUser aspNetUser = db.AspNetUsers.Find(id);
            if (aspNetUser == null)
            {
                return HttpNotFound();
            }

            return View(aspNetUser);
        }

        // POST: Users/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include =
                "Id,Email,EmailConfirmed,PasswordHash,SecurityStamp,PhoneNumber,PhoneNumberConfirmed,TwoFactorEnabled,LockoutEndDateUtc,LockoutEnabled,AccessFailedCount,UserName")]
            AspNetUser aspNetUser)
        {
            if (ModelState.IsValid)
            {
                db.Entry(aspNetUser).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(aspNetUser);
        }

        // GET: Users/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            AspNetUser aspNetUser = db.AspNetUsers.Find(id);
            if (aspNetUser == null)
            {
                return HttpNotFound();
            }

            return View(aspNetUser);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            AspNetUser aspNetUser = db.AspNetUsers.Find(id);
            db.AspNetUsers.Remove(aspNetUser);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }

            base.Dispose(disposing);
        }
    }

    public class UserDisplay
    {
        public string UserID { get; set; }
        public string UserName { get; set; }
        public int NbrSub { get; set; }
        public int NbrRep { get; set; }
        public DateTime? LastDate { get; set; }
    }
}