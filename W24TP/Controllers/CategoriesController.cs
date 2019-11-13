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
    public class CategoriesController : Controller
    {
        private ForumONIEntities db = new ForumONIEntities();

        // GET: Categories
        public ActionResult Index()
        {
            return View(db.Categories.Select(cat => new CategoryDisplay
            {
                CatID = cat.CatID,
                CategoryName = cat.CategoryName,
                CreationDate = cat.CreationDate,
                User = cat.AspNetUser.UserName,
                IsActive = cat.IsActive,
                LastThreePosts = db.Messages
                        .Where(t => t.CatID == cat.CatID)
                        .OrderByDescending(t => t.CreationDate)
                        .Take(3).ToList(),
                Messages = db.Messages
                        .Where(t => t.CatID == cat.CatID)
                        .OrderByDescending(t => t.CreationDate)
                        .ToList()
            }).ToList());
        }

        // GET: Categories/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }

            return View(new CategoryDisplay
            {
                CatID = category.CatID,
                CategoryName = category.CategoryName,
                CreationDate = category.CreationDate,
                User = category.AspNetUser.UserName,
                IsActive = category.IsActive,
                LastThreePosts = db.Messages
                    .Where(t => t.CatID == category.CatID)
                    .OrderByDescending(t => t.CreationDate)
                    .Take(3).ToList(),
                Messages = db.Messages
                    .Where(t => t.CatID == category.CatID)
                    .OrderByDescending(t => t.CreationDate)
                    .ToList()
            });
        }

        // GET: Categories/Create
        public ActionResult Create()
        {
            ViewBag.User = new SelectList(db.AspNetUsers, "Id", "Email");
            return View();
        }

        // POST: Categories/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CatID,CategoryName,IsActive,CreationDate,User")]
            Category category)
        {
            if (ModelState.IsValid)
            {
                db.Categories.Add(category);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.User = new SelectList(db.AspNetUsers, "Id", "Email", category.UserID);
            return View(category);
        }

        // GET: Categories/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }

            ViewBag.User = new SelectList(db.AspNetUsers, "Id", "Email", category.UserID);
            return View(category);
        }

        // POST: Categories/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CatID,CategoryName,IsActive,CreationDate,User")]
            Category category)
        {
            if (ModelState.IsValid)
            {
                db.Entry(category).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.User = new SelectList(db.AspNetUsers, "Id", "Email", category.UserID);
            return View(category);
        }

        // GET: Categories/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }

            return View(category);
        }

        // POST: Categories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Category category = db.Categories.Find(id);
            db.Categories.Remove(category);
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

    public class CategoryDisplay
    {
        public int CatID { get; set; }
        public string CategoryName { get; set; }
        public DateTime CreationDate { get; set; }
        public string User { get; set; }
        public bool IsActive { get; set; }
        public List<Message> LastThreePosts { get; set; }
        public List<Message> Messages { get; set; }
    }
}