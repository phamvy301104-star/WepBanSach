using System;
using System.Linq;
using System.Web.Mvc;
using WebBanSach.Models;

namespace WebBanSach.Controllers
{
    public class AccountController : Controller
    {
        private WebBanSachContext db = new WebBanSachContext();

        // GET: Account/Register
        public ActionResult Register()
        {
            return View();
        }

        // POST: Account/Register
        [HttpPost]
        public ActionResult Register(FormCollection collection)
        {
            string hoTen = collection["HoTen"];
            string tenDN = collection["TenDN"];
            string matkhau = collection["Matkhau"];
            string email = collection["Email"];
            string diaChi = collection["DiaChi"];
            string dienThoai = collection["DienThoai"];
            string ngaySinhStr = collection["NgaySinh"];

            bool hasError = false;
            if (string.IsNullOrEmpty(hoTen))
            {
                ViewData["Loi_HoTen"] = "Ho ten khach hang khong duoc de trong";
                hasError = true;
            }
            if (string.IsNullOrEmpty(dienThoai))
            {
                ViewData["Loi_DienThoai"] = "Phai nhap dien thoai";
                hasError = true;
            }
            if (hasError)
                return View();

            DateTime ngaySinh = DateTime.Now;
            DateTime.TryParse(ngaySinhStr, out ngaySinh);

            var user = new User
            {
                FullName = hoTen,
                Email = email,
                Password = matkhau,
                Phone = dienThoai,
                Address = diaChi,
                DateOfBirth = ngaySinh,
                IsActive = true,
                CreatedDate = DateTime.Now,
                Role = 0
            };

            // Store TenDN in FullName if no separate field, or use a custom approach
            // Save to DB using the Username as FullName since model has no Username field
            db.Users.Add(user);
            db.SaveChanges();

            TempData["SuccessMessage"] = "Dang ky thanh cong! Vui long dang nhap.";
            return RedirectToAction("Login");
        }

        // GET: Account/Login
        public ActionResult Login()
        {
            return View();
        }

        // POST: Account/Login
        [HttpPost]
        public ActionResult Login(FormCollection collection)
        {
            string tenDN = collection["TenDN"];
            string matkhau = collection["Matkhau"];

            bool hasError = false;
            if (string.IsNullOrEmpty(tenDN))
            {
                ViewData["Loi1"] = "Phai nhap ten dang nhap";
                hasError = true;
            }
            if (string.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "Phai nhap mat khau";
                hasError = true;
            }
            if (hasError)
                return View();

            var user = db.Users.FirstOrDefault(u => u.Email == tenDN && u.Password == matkhau && u.IsActive);

            if (user != null)
            {
                Session["UserID"] = user.UserID;
                Session["FullName"] = user.FullName;
                Session["Email"] = user.Email;
                Session["Role"] = user.Role;

                if (user.Role == 1)
                    return RedirectToAction("Dashboard", "Admin");
                else
                    return RedirectToAction("Index", "Home");
            }

            ViewBag.Thongbao = "Ten dang nhap hoac mat khau khong dung";
            return View();
        }

        // GET: Account/Logout
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
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
