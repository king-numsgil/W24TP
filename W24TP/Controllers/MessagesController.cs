﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using W24TP.Models;
using PagedList;

namespace W24TP.Controllers
{
    public class MessagesController : Controller
    {
        private ForumONIEntities db = new ForumONIEntities();

        // GET: Messages/Details/5
        public ActionResult Details(int? id, string path, int? page)
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
                message.View++;

                db.Entry(message).State = EntityState.Modified;
                db.SaveChanges();

                return View(new PostDisplay
                {
                    MsgID = message.MsgID,
                    MsgTitle = message.MsgTitle,
                    Views = message.View,
                    MsgText = message.MsgText,
                    CatID = message.CatID,
                    CategoryName = message.Category.CategoryName,
                    User = message.AspNetUser.UserName,
                    UserID = message.AspNetUser.Id,
                    CreationDate = message.CreationDate,
                    IsActive = message.IsActive,
                    RepliesList = db.Reponses
                            .Where(r => r.MsgID == message.MsgID)
                            .OrderBy(r => r.CreationDate)
                            .ToPagedList(page ?? 1, 8) as PagedList<Reponse>
                });
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
        public ActionResult Create([Bind(Include = "MsgID,MsgTitle,MsgText,CatID,UserID,CreationDate,View,IsActive")]
            Message message)
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
        public ActionResult Edit([Bind(Include = "MsgID,MsgTitle,MsgText,CatID,UserID,CreationDate,View,IsActive")]
            Message message)
        {
            if (ModelState.IsValid)
            {
                db.Entry(message).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Details", new { id = message.MsgID, path = "Categories" });
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
            return RedirectToAction("Details", "Categories", new { id = message.CatID });
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
        public int Views { get; set; }
        public string MsgText { get; set; }
        public int CatID { get; set; }
        public string CategoryName { get; set; }
        public string User { get; set; }
        public string UserID { get; set; }
        public DateTime CreationDate { get; set; }
        public bool IsActive { get; set; }
        public PagedList<Reponse> RepliesList { get; set; }
    }

    public class MessageDisplay
    {
        public int MsgID { get; set; }
        public string MsgTitle { get; set; }
        public string MsgText { get; set; }
        public string CategoryName { get; set; }
        public string User { get; set; }
        public DateTime CreationDate { get; set; }
        public int Views { get; set; }
        public bool IsActive { get; set; }
    }
}