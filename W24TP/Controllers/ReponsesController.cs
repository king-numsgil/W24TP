using Microsoft.AspNet.Identity;
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

        [HttpPost]
        [Authorize]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public ActionResult Create(int? id, string path, string reply)
        {
            var rep = new Reponse
            {
                MsgID = id,
                IsActive = true,
                RepText = reply,
                CreationDate = DateTime.Now,
                UserID = User.Identity.GetUserId()
            };
            db.Reponses.Add(rep);
            db.SaveChanges();

            return RedirectToAction("Details", "Messages", new { id, path });
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