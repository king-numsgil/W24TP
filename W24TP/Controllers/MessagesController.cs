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
    public class MessagesController : Controller
    {
        private ForumONIEntities db = new ForumONIEntities();

        // GET: Messages
        public ActionResult Index()
        {
            //var messages = db.Messages.Include(m => m.AspNetUser).Include(m => m.Category);
            //return View(messages.ToList());

            var messages = (from m in db.Messages
                            select new MessageDisplay
                            {
                                MsgID = m.MsgID,
                                MsgTitle = m.MsgTitle,
                                Views = m.View,
                                MsgText = m.MsgText,
                                CategoryName = m.Category.CategoryName,
                                User = m.AspNetUser.UserName,
                                CreationDate = m.CreationDate,
                                IsActive = m.IsActive
                            }).ToList();
            return View(messages);
        }

        // GET: Messages/Details/5
        public ActionResult Details(int? id, string path)
        {
            //Retiens l'url d'ou l'utilisateur arrive pour un 'Back to List' plus dynamique
            ViewBag.OldUrl = path;

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            else
            {
                var post = (from p in db.Messages
                            where p.MsgID == id
                            select new PostDisplay
                            {
                                MsgID = p.MsgID,
                                MsgTitle = p.MsgTitle,
                                Views = p.View,
                                MsgText = p.MsgText,
                                CatID = p.Category.CatID,
                                CategoryName = p.Category.CategoryName,
                                User = p.AspNetUser.UserName,
                                CreationDate = p.CreationDate,
                                IsActive = p.IsActive,
                                RepliesList = db.Reponses
                                    .Where(r => r.MsgID == p.MsgID)
                                    .OrderByDescending(r => r.CreationDate)
                                    .ToList()
                            }).FirstOrDefault();
                return View(post);
            }
        }

        // GET: Messages/Create
        public ActionResult Create()
        {
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email");
            ViewBag.CatID = new SelectList(db.Categories, "CatID", "CategoryName");
            return View();
        }

        // POST: Messages/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MsgID,MsgTitle,MsgText,CatID,UserID,CreationDate,View,IsActive")] Message message)
        {
            if (ModelState.IsValid)
            {
                db.Messages.Add(message);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", message.UserID);
            ViewBag.CatID = new SelectList(db.Categories, "CatID", "CategoryName", message.CatID);
            return View(message);
        }

        // GET: Messages/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", message.UserID);
            ViewBag.CatID = new SelectList(db.Categories, "CatID", "CategoryName", message.CatID);
            return View(message);
        }

        // POST: Messages/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MsgID,MsgTitle,MsgText,CatID,UserID,CreationDate,View,IsActive")] Message message)
        {
            if (ModelState.IsValid)
            {
                db.Entry(message).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", message.UserID);
            ViewBag.CatID = new SelectList(db.Categories, "CatID", "CategoryName", message.CatID);
            return View(message);
        }

        // GET: Messages/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            return View(message);
        }

        // POST: Messages/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Message message = db.Messages.Find(id);
            db.Messages.Remove(message);
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

    public class PostDisplay
    {
        public int MsgID { get; set; }
        public string MsgTitle { get; set; }
        public string Views { get; set; }
        public string MsgText { get; set; }
        public int CatID { get; set; }
        public string CategoryName { get; set; }
        public string User { get; set; }
        public DateTime CreationDate { get; set; }
        public bool? IsActive { get; set; }
        public List<Reponse> RepliesList { get; set; }
    }

    public class MessageDisplay
    {
        public int MsgID { get; set; }
        public string MsgTitle { get; set; }
        public string MsgText { get; set; }
        public string CategoryName { get; set; }
        public string User { get; set; }
        public DateTime CreationDate { get; set; }
        public string Views { get; set; }
        public bool? IsActive { get; set; }
    }
}
