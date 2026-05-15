using System;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanSach.Models;
using PagedList;

namespace WebBanSach.Controllers
{
    public class AdminController : Controller
    {
        private WebBanSachContext db = new WebBanSachContext();

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            string actionName = filterContext.ActionDescriptor.ActionName;
            if (actionName == "Login") return;
            if (Session["UserID"] == null || (int?)Session["Role"] != 1)
            {
                filterContext.Result = RedirectToAction("Login", "Admin");
            }
        }

        // GET: Admin/Login
        public ActionResult Login()
        {
            return View();
        }

        // POST: Admin/Login
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            string username = collection["username"];
            string password = collection["password"];

            var user = db.Users.FirstOrDefault(u => u.Email == username && u.Password == password && u.Role == 1 && u.IsActive);
            if (user != null)
            {
                Session["UserID"] = user.UserID;
                Session["FullName"] = user.FullName;
                Session["Role"] = user.Role;
                return RedirectToAction("Dashboard", "Admin");
            }

            ViewBag.Error = "Ten dang nhap hoac mat khau khong dung";
            return View();
        }

        // GET: Admin/Dashboard
        public ActionResult Dashboard()
        {
            var totalBooks = db.Books.Count();
            var totalOrders = db.Orders.Count();
            var totalUsers = db.Users.Count();
            var totalRevenue = db.Orders.Sum(o => (decimal?)o.TotalAmount) ?? 0;

            ViewBag.TotalBooks = totalBooks;
            ViewBag.TotalOrders = totalOrders;
            ViewBag.TotalUsers = totalUsers;
            ViewBag.TotalRevenue = totalRevenue;

            return View();
        }

        // GET: Admin/Books
        public ActionResult Books(int? page)
        {
            var books = db.Books.OrderByDescending(b => b.CreatedDate).ToList();

            int pageSize = 10;
            int pageNumber = (page ?? 1);

            return View(books.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/CreateBook
        public ActionResult CreateBook()
        {
            ViewBag.Categories = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.Publishers = new SelectList(db.Publishers, "PublisherID", "PublisherName");
            return View();
        }

        // POST: Admin/CreateBook
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateBook(Book book)
        {
            if (ModelState.IsValid)
            {
                book.CreatedDate = DateTime.Now;
                book.IsActive = true;

                // Handle image upload
                if (Request.Files.Count > 0)
                {
                    var file = Request.Files[0];
                    if (file != null && file.ContentLength > 0)
                    {
                        string fileName = System.IO.Path.GetFileNameWithoutExtension(file.FileName);
                        string fileExt = System.IO.Path.GetExtension(file.FileName);
                        fileName = fileName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + fileExt;
                        string uploadPath = System.IO.Path.Combine(Server.MapPath("~/Content/Images"), fileName);
                        file.SaveAs(uploadPath);
                        book.ImagePath = "/Content/Images/" + fileName;
                    }
                }

                db.Books.Add(book);
                db.SaveChanges();

                TempData["SuccessMessage"] = "Book created successfully!";
                return RedirectToAction("Books");
            }

            ViewBag.Categories = new SelectList(db.Categories, "CategoryID", "CategoryName", book.CategoryID);
            ViewBag.Publishers = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // GET: Admin/EditBook
        public ActionResult EditBook(int id)
        {
            var book = db.Books.Find(id);
            if (book == null)
                return HttpNotFound();

            ViewBag.Categories = new SelectList(db.Categories, "CategoryID", "CategoryName", book.CategoryID);
            ViewBag.Publishers = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // POST: Admin/EditBook
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditBook(Book book)
        {
            if (ModelState.IsValid)
            {
                var existingBook = db.Books.Find(book.BookID);
                if (existingBook == null)
                    return HttpNotFound();

                existingBook.BookTitle = book.BookTitle;
                existingBook.Author = book.Author;
                existingBook.Description = book.Description;
                existingBook.Price = book.Price;
                existingBook.Quantity = book.Quantity;
                existingBook.CategoryID = book.CategoryID;
                existingBook.PublisherID = book.PublisherID;
                existingBook.PublishedDate = book.PublishedDate;

                // Handle image upload
                if (Request.Files.Count > 0)
                {
                    var file = Request.Files[0];
                    if (file != null && file.ContentLength > 0)
                    {
                        string fileName = System.IO.Path.GetFileNameWithoutExtension(file.FileName);
                        string fileExt = System.IO.Path.GetExtension(file.FileName);
                        fileName = fileName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + fileExt;
                        string uploadPath = System.IO.Path.Combine(Server.MapPath("~/Content/Images"), fileName);
                        file.SaveAs(uploadPath);
                        existingBook.ImagePath = "/Content/Images/" + fileName;
                    }
                }

                db.SaveChanges();

                TempData["SuccessMessage"] = "Book updated successfully!";
                return RedirectToAction("Books");
            }

            ViewBag.Categories = new SelectList(db.Categories, "CategoryID", "CategoryName", book.CategoryID);
            ViewBag.Publishers = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // POST: Admin/DeleteBook
        [HttpPost]
        public ActionResult DeleteBook(int id)
        {
            var book = db.Books.Find(id);
            if (book != null)
            {
                db.Books.Remove(book);
                db.SaveChanges();
            }

            return RedirectToAction("Books");
        }

        // ============================================================
        // LAB 12: QUẢN LÝ SẢN PHẨM
        // ============================================================

        // GET: Admin/Sach
        public ActionResult Sach(int? page)
        {
            var books = db.Books.Include("Category").Include("Publisher").OrderBy(b => b.BookTitle).ToList();
            int pageSize = 7;
            int pageNumber = (page ?? 1);
            return View(books.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/ThemmoiSach
        public ActionResult ThemmoiSach()
        {
            ViewBag.MaCD = new SelectList(db.Categories.OrderBy(c => c.CategoryName).ToList(), "CategoryID", "CategoryName");
            ViewBag.MaNXB = new SelectList(db.Publishers.OrderBy(p => p.PublisherName).ToList(), "PublisherID", "PublisherName");
            return View();
        }

        // POST: Admin/ThemmoiSach
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ThemmoiSach(Book book, HttpPostedFileBase fileUpload)
        {
            ViewBag.MaCD = new SelectList(db.Categories.OrderBy(c => c.CategoryName).ToList(), "CategoryID", "CategoryName");
            ViewBag.MaNXB = new SelectList(db.Publishers.OrderBy(p => p.PublisherName).ToList(), "PublisherID", "PublisherName");

            if (fileUpload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa";
                return View();
            }

            var fileName = System.IO.Path.GetFileName(fileUpload.FileName);
            var path = System.IO.Path.Combine(Server.MapPath("~/Hinhsanpham"), fileName);

            if (System.IO.File.Exists(path))
                ViewBag.Thongbao = "Hình ảnh đã tồn tại";
            else
                fileUpload.SaveAs(path);

            book.ImagePath = fileName;
            book.CreatedDate = DateTime.Now;
            book.IsActive = true;
            db.Books.Add(book);
            db.SaveChanges();
            return RedirectToAction("Sach");
        }

        // GET: Admin/Chitietsach
        public ActionResult Chitietsach(int id)
        {
            var book = db.Books.Include("Category").Include("Publisher").FirstOrDefault(b => b.BookID == id);
            if (book == null) return HttpNotFound();
            return View(book);
        }

        // GET: Admin/Xoasach
        public ActionResult Xoasach(int id)
        {
            var book = db.Books.Include("Category").Include("Publisher").FirstOrDefault(b => b.BookID == id);
            if (book == null) return HttpNotFound();
            return View(book);
        }

        // POST: Admin/Xacnhanxoa
        [HttpPost]
        public ActionResult Xacnhanxoa(int id)
        {
            var book = db.Books.Find(id);
            if (book != null)
            {
                try
                {
                    db.Books.Remove(book);
                    db.SaveChanges();
                }
                catch
                {
                    ViewBag.Error = "Không thể xóa sách này vì đang có quan hệ với dữ liệu khác.";
                    var b = db.Books.Include("Category").Include("Publisher").FirstOrDefault(x => x.BookID == id);
                    return View("Xoasach", b);
                }
            }
            return RedirectToAction("Sach");
        }

        // GET: Admin/Suasach
        public ActionResult Suasach(int id)
        {
            var book = db.Books.Find(id);
            if (book == null) return HttpNotFound();
            ViewBag.MaCD = new SelectList(db.Categories.OrderBy(c => c.CategoryName).ToList(), "CategoryID", "CategoryName", book.CategoryID);
            ViewBag.MaNXB = new SelectList(db.Publishers.OrderBy(p => p.PublisherName).ToList(), "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // POST: Admin/Suasach
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Suasach(Book book, HttpPostedFileBase fileUpload)
        {
            ViewBag.MaCD = new SelectList(db.Categories.OrderBy(c => c.CategoryName).ToList(), "CategoryID", "CategoryName", book.CategoryID);
            ViewBag.MaNXB = new SelectList(db.Publishers.OrderBy(p => p.PublisherName).ToList(), "PublisherID", "PublisherName", book.PublisherID);

            var existing = db.Books.Find(book.BookID);
            if (existing == null) return HttpNotFound();

            existing.BookTitle = book.BookTitle;
            existing.Author = book.Author;
            existing.Description = book.Description;
            existing.Price = book.Price;
            existing.Quantity = book.Quantity;
            existing.PublishedDate = book.PublishedDate;
            existing.CategoryID = book.CategoryID;
            existing.PublisherID = book.PublisherID;

            if (fileUpload != null && fileUpload.ContentLength > 0)
            {
                var fileName = System.IO.Path.GetFileName(fileUpload.FileName);
                var path = System.IO.Path.Combine(Server.MapPath("~/Hinhsanpham"), fileName);
                if (!System.IO.File.Exists(path))
                    fileUpload.SaveAs(path);
                existing.ImagePath = fileName;
            }

            db.SaveChanges();
            return RedirectToAction("Sach");
        }

        // GET: Admin/Orders
        public ActionResult Orders(int? page)
        {
            var orders = db.Orders.OrderByDescending(o => o.OrderDate).ToList();

            int pageSize = 10;
            int pageNumber = (page ?? 1);

            return View(orders.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/OrderDetails
        public ActionResult OrderDetails(int id)
        {
            var order = db.Orders.Find(id);
            if (order == null)
                return HttpNotFound();

            var orderDetails = db.OrderDetails.Where(od => od.OrderID == id).Include("Book").ToList();
            return View(orderDetails);
        }

        // POST: Admin/UpdateOrderStatus
        [HttpPost]
        public ActionResult UpdateOrderStatus(int orderId, int status)
        {
            var order = db.Orders.Find(orderId);
            if (order != null)
            {
                order.Status = status;
                order.UpdatedDate = DateTime.Now;
                db.SaveChanges();
            }

            return RedirectToAction("Orders");
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
