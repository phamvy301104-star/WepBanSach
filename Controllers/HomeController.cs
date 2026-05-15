using System;
using System.Linq;
using System.Web.Mvc;
using WebBanSach.Models;
using PagedList;

namespace WebBanSach.Controllers
{
    public class HomeController : Controller
    {
        private WebBanSachContext db = new WebBanSachContext();

        private void LoadSidebarData()
        {
            ViewBag.Categories = db.Categories.ToList();
            ViewBag.Publishers = db.Publishers.ToList();
        }

        // GET: Home
        public ActionResult Index(int? page)
        {
            LoadSidebarData();
            var books = db.Books.Where(b => b.IsActive).OrderByDescending(b => b.CreatedDate).ToList();
            
            int pageSize = 10;
            int pageNumber = (page ?? 1);

            return View(books.ToPagedList(pageNumber, pageSize));
        }

        // GET: Home/Category
        public ActionResult Category(int id, int? page)
        {
            LoadSidebarData();
            var category = db.Categories.Find(id);
            if (category == null)
                return HttpNotFound();

            var books = db.Books.Where(b => b.CategoryID == id && b.IsActive)
                .OrderByDescending(b => b.CreatedDate).ToList();

            int pageSize = 10;
            int pageNumber = (page ?? 1);

            ViewBag.CategoryName = category.CategoryName;
            return View("Index", books.ToPagedList(pageNumber, pageSize));
        }

        // GET: Home/Publisher
        public ActionResult Publisher(int id, int? page)
        {
            LoadSidebarData();
            var publisher = db.Publishers.Find(id);
            if (publisher == null)
                return HttpNotFound();

            var books = db.Books.Where(b => b.PublisherID == id && b.IsActive)
                .OrderByDescending(b => b.CreatedDate).ToList();

            int pageSize = 10;
            int pageNumber = (page ?? 1);

            ViewBag.PublisherName = publisher.PublisherName;
            return View("Index", books.ToPagedList(pageNumber, pageSize));
        }

        // GET: Home/Details
        public ActionResult Details(int id)
        {
            LoadSidebarData();
            var book = db.Books.Find(id);
            if (book == null)
                return HttpNotFound();

            return View(book);
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
