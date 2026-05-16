using System;
using System.Data.SqlClient;
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
                ViewData["Loi_HoTen"] = "Họ tên không được để trống";
                hasError = true;
            }
            if (string.IsNullOrEmpty(dienThoai))
            {
                ViewData["Loi_DienThoai"] = "Phải nhập điện thoại";
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

            // Cũng lưu vào bảng KHACHHANG
            try
            {
                db.Database.ExecuteSqlCommand(
                    "INSERT INTO KHACHHANG (HoTen, Taikhoan, Matkhau, Email, DiachiKH, DienthoaiKH, Ngaysinh) VALUES (@p0, @p1, @p2, @p3, @p4, @p5, @p6)",
                    hoTen ?? "",
                    tenDN ?? "",
                    matkhau ?? "",
                    email ?? "",
                    diaChi ?? "",
                    dienThoai ?? "",
                    ngaySinh);
            }
            catch { /* bỏ qua nếu trùng */ }

            TempData["SuccessMessage"] = "Đăng ký thành công! Vui lòng đăng nhập.";
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

                // Lấy MaKH từ KHACHHANG để dùng khi đặt hàng
                try
                {
                    var maKH = db.Database.SqlQuery<int?>(
                        "SELECT TOP 1 MaKH FROM KHACHHANG WHERE Email = @p0",
                        user.Email).FirstOrDefault();
                    if (maKH.HasValue)
                        Session["MaKH"] = maKH.Value;
                }
                catch { }

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
