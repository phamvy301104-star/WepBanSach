using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using WebBanSach.Models;

namespace WebBanSach.Controllers
{
    public class CartController : Controller
    {
        private WebBanSachContext db = new WebBanSachContext();

        // GET: Cart/Index
        public ActionResult Index()
        {
            if (Session["UserID"] == null)
                return RedirectToAction("Login", "Account");

            int userId = (int)Session["UserID"];
            var cartItems = db.CartItems.Where(c => c.UserID == userId)
                .Include("Book").ToList();

            return View(cartItems);
        }

        // POST: Cart/Add
        [HttpPost]
        public ActionResult Add(int bookId, int quantity)
        {
            if (Session["UserID"] == null)
                return Json(new { success = false, message = "Please login first!" });

            int userId = (int)Session["UserID"];
            var book = db.Books.Find(bookId);

            if (book == null)
                return Json(new { success = false, message = "Book not found!" });

            var cartItem = db.CartItems.FirstOrDefault(c => c.UserID == userId && c.BookID == bookId);

            if (cartItem != null)
            {
                cartItem.Quantity += quantity;
            }
            else
            {
                cartItem = new CartItem
                {
                    UserID = userId,
                    BookID = bookId,
                    Quantity = quantity,
                    AddedDate = DateTime.Now
                };
                db.CartItems.Add(cartItem);
            }

            db.SaveChanges();
            return Json(new { success = true, message = "Added to cart successfully!" });
        }

        // POST: Cart/Update
        [HttpPost]
        public ActionResult Update(int cartItemId, int quantity)
        {
            var cartItem = db.CartItems.Find(cartItemId);

            if (cartItem == null)
                return Json(new { success = false });

            if (quantity <= 0)
            {
                db.CartItems.Remove(cartItem);
            }
            else
            {
                cartItem.Quantity = quantity;
            }

            db.SaveChanges();
            return Json(new { success = true });
        }

        // POST: Cart/Remove
        [HttpPost]
        public ActionResult Remove(int cartItemId)
        {
            var cartItem = db.CartItems.Find(cartItemId);

            if (cartItem != null)
            {
                db.CartItems.Remove(cartItem);
                db.SaveChanges();
            }

            return RedirectToAction("Index");
        }

        // POST: Cart/Checkout
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Checkout(string shippingAddress, string note)
        {
            if (Session["UserID"] == null)
                return RedirectToAction("Login", "Account");

            int userId = (int)Session["UserID"];
            var cartItems = db.CartItems.Where(c => c.UserID == userId).Include("Book").ToList();

            if (cartItems.Count == 0)
            {
                TempData["ErrorMessage"] = "Cart is empty!";
                return RedirectToAction("Index");
            }

            // Create order
            var order = new Order
            {
                UserID = userId,
                OrderDate = DateTime.Now,
                Status = 0, // Pending
                ShippingAddress = shippingAddress,
                Note = note,
                UpdatedDate = DateTime.Now
            };

            // Calculate total amount
            decimal totalAmount = 0;
            foreach (var item in cartItems)
            {
                totalAmount += item.Book.Price * item.Quantity;
            }
            order.TotalAmount = totalAmount;

            db.Orders.Add(order);
            db.SaveChanges();

            // Create order details
            foreach (var cartItem in cartItems)
            {
                var orderDetail = new OrderDetail
                {
                    OrderID = order.OrderID,
                    BookID = cartItem.BookID,
                    Quantity = cartItem.Quantity,
                    UnitPrice = cartItem.Book.Price,
                    TotalPrice = cartItem.Book.Price * cartItem.Quantity
                };
                db.OrderDetails.Add(orderDetail);
            }

            // Clear cart
            db.CartItems.RemoveRange(cartItems);
            db.SaveChanges();

            TempData["SuccessMessage"] = "Order placed successfully!";
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
