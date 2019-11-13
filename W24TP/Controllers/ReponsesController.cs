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
    public class ReponsesController : Controller
    {
        private ForumONIEntities db = new ForumONIEntities();

        // GET: Reponses
        public ActionResult Index()
        {
            var reponses = db.Reponses.Include(r => r.AspNetUser).Include(r => r.Message);
            return View(reponses.ToList());
        }

        // GET: Reponses/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Reponse reponse = db.Reponses.Find(id);
            if (reponse == null)
            {
                return HttpNotFound();
            }

            return View(reponse);
        }

        // GET: Reponses/Create
        public ActionResult Create()
        {
            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email");
            ViewBag.MsgID = new SelectList(db.Messages, "MsgID", "MsgTitle");
            return View();
        }

        // POST: Reponses/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "RepID,RepText,MsgID,UserID,CreationDate,IsActive")]
            Reponse reponse)
        {
            if (ModelState.IsValid)
            {
                db.Reponses.Add(reponse);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", reponse.UserID);
            ViewBag.MsgID = new SelectList(db.Messages, "MsgID", "MsgTitle", reponse.MsgID);
            return View(reponse);
        }

        // GET: Reponses/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Reponse reponse = db.Reponses.Find(id);
            if (reponse == null)
            {
                return HttpNotFound();
            }

            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", reponse.UserID);
            ViewBag.MsgID = new SelectList(db.Messages, "MsgID", "MsgTitle", reponse.MsgID);
            return View(reponse);
        }

        // POST: Reponses/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "RepID,RepText,MsgID,UserID,CreationDate,IsActive")]
            Reponse reponse)
        {
            if (ModelState.IsValid)
            {
                db.Entry(reponse).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserID = new SelectList(db.AspNetUsers, "Id", "Email", reponse.UserID);
            ViewBag.MsgID = new SelectList(db.Messages, "MsgID", "MsgTitle", reponse.MsgID);
            return View(reponse);
        }

        // GET: Reponses/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Reponse reponse = db.Reponses.Find(id);
            if (reponse == null)
            {
                return HttpNotFound();
            }

            return View(reponse);
        }

        // POST: Reponses/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Reponse reponse = db.Reponses.Find(id);
            db.Reponses.Remove(reponse);
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
}