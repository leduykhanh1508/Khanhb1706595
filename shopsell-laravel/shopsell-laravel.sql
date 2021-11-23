-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 15, 2021 lúc 04:04 AM
-- Phiên bản máy phục vụ: 10.4.20-MariaDB
-- Phiên bản PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shopsell-laravel`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(5, '2021_10_23_052601_create_tbl_admin_table', 1),
(6, '2021_10_23_083524_create_tbl_product', 2),
(7, '2021_10_23_090205_create_tbl_product', 3),
(8, '2021_10_23_090458_create_tbl_product', 4),
(9, '2021_10_26_164116_create_tbl_brandproduct', 5),
(10, '2021_10_29_115519_create_tbl_productdetail', 6),
(12, '2021_10_29_120059_create_tbl_productdetails', 7),
(13, '2021_11_13_150426_create_tbl_payment', 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_admin`
--

INSERT INTO `tbl_admin` (`id`, `admin_email`, `admin_password`, `admin_name`, `admin_phone`, `created_at`, `updated_at`) VALUES
(1, 'duykhanh@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Duy Khanh', '0123456789', '2021-10-23 05:37:54', NULL),
(2, 'admin@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'Duy Khanh', '0147258369', '2021-10-23 07:04:53', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_brand`
--

CREATE TABLE `tbl_brand` (
  `brand_id` int(10) UNSIGNED NOT NULL,
  `brand_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_desc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_brand`
--

INSERT INTO `tbl_brand` (`brand_id`, `brand_name`, `brand_slug`, `brand_desc`, `brand_status`, `created_at`, `updated_at`) VALUES
(1, 'Sam Sung', '', 'Thương hiệu đồ điện, điện tử nổi tiếng Hàn Quốc', 0, NULL, NULL),
(3, 'Xiaomi', '', 'Thương hiệu nổ tiếng với đồ dùng điện tử', 0, NULL, NULL),
(9, 'LG', NULL, '<p>Thương hiệu nổi tiếng đến từ H&agrave;n Quốc</p>', 0, NULL, NULL),
(10, 'Sony', NULL, '<p>Thương hiệu đến từ Nhật Bản, với chất lượng cực cao</p>', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_category_product`
--

CREATE TABLE `tbl_category_product` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug_category_product` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_desc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_category_product`
--

INSERT INTO `tbl_category_product` (`category_id`, `category_name`, `slug_category_product`, `category_desc`, `category_status`, `created_at`, `updated_at`) VALUES
(1, 'Laptop', '', 'Laptop', 0, NULL, NULL),
(2, 'TiVi', '', 'TiVi Siêu mỏng', 0, NULL, NULL),
(3, 'Máy Lạnh', '', 'Máy Lạnh', 0, NULL, NULL),
(4, 'Điện Thoại', '', 'Smart phone', 0, NULL, NULL),
(6, 'Máy giặt', '', 'Máy giặt', 0, NULL, NULL),
(8, 'Máy nước nóng', '', 'Máy nước nóng', 0, NULL, NULL),
(17, 'Laptop', NULL, '1111111', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_customers`
--

CREATE TABLE `tbl_customers` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_customers`
--

INSERT INTO `tbl_customers` (`customer_id`, `customer_name`, `customer_email`, `customer_password`, `customer_phone`, `created_at`, `updated_at`) VALUES
(2, 'Le Duy Khanh', 'khanh1508@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', '1234567890', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_feeship`
--

CREATE TABLE `tbl_feeship` (
  `fee_id` int(11) NOT NULL,
  `fee_matp` int(10) NOT NULL,
  `fee_maqh` int(10) NOT NULL,
  `fee_xaid` int(10) NOT NULL,
  `fee_feeship` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_order`
--

CREATE TABLE `tbl_order` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `shipping_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `order_status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_total` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_destroy` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_order`
--

INSERT INTO `tbl_order` (`order_id`, `customer_id`, `shipping_id`, `payment_id`, `order_status`, `order_total`, `order_date`, `order_destroy`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 2, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(2, 1, 2, 3, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(3, 1, 2, 4, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(4, 1, 2, 5, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(5, 1, 2, 6, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(7, 2, 3, 8, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(8, 2, 4, 9, 'Đang chờ xử lý', '5,565,692.22', NULL, NULL, NULL, NULL),
(9, 2, 5, 10, 'Đang chờ xử lý', '16,697,076.66', NULL, NULL, NULL, NULL),
(10, 2, 7, 11, 'Đang chờ xử lý', '8,160,000.00', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_order_details`
--

CREATE TABLE `tbl_order_details` (
  `order_details_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(11) NOT NULL,
  `order_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_price` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_sales_quantity` int(11) NOT NULL,
  `product_coupon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_feeship` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_order_details`
--

INSERT INTO `tbl_order_details` (`order_details_id`, `order_id`, `order_code`, `product_id`, `product_name`, `product_price`, `product_sales_quantity`, `product_coupon`, `product_feeship`, `created_at`, `updated_at`) VALUES
(1, 5, NULL, 1, 'tivi samsung', '5456561', 1, NULL, NULL, NULL, NULL),
(2, 7, NULL, 1, 'tivi samsung', '5456561', 1, NULL, NULL, NULL, NULL),
(3, 8, NULL, 1, 'tivi samsung', '5456561', 1, NULL, NULL, NULL, NULL),
(4, 9, NULL, 4, 'tivi samsung', '5456561', 3, NULL, NULL, NULL, NULL),
(5, 10, NULL, 9, 'TiVi Sony 2021', '8000000', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_payment`
--

CREATE TABLE `tbl_payment` (
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_payment`
--

INSERT INTO `tbl_payment` (`payment_id`, `payment_method`, `payment_status`, `created_at`, `updated_at`) VALUES
(1, '2', 'Đang chờ xử lý', NULL, NULL),
(2, '2', 'Đang chờ xử lý', NULL, NULL),
(3, '2', 'Đang chờ xử lý', NULL, NULL),
(4, '2', 'Đang chờ xử lý', NULL, NULL),
(5, '2', 'Đang chờ xử lý', NULL, NULL),
(6, '2', 'Đang chờ xử lý', NULL, NULL),
(7, '2', 'Đang chờ xử lý', NULL, NULL),
(8, '2', 'Đang chờ xử lý', NULL, NULL),
(9, '2', 'Đang chờ xử lý', NULL, NULL),
(10, '2', 'Đang chờ xử lý', NULL, NULL),
(11, '2', 'Đang chờ xử lý', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_product`
--

CREATE TABLE `tbl_product` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `product_desc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_quantity` int(50) NOT NULL,
  `product_discount` int(50) DEFAULT NULL,
  `product_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_product`
--

INSERT INTO `tbl_product` (`product_id`, `product_name`, `category_id`, `brand_id`, `product_desc`, `product_quantity`, `product_discount`, `product_content`, `product_price`, `product_image`, `product_status`, `created_at`, `updated_at`) VALUES
(4, 'tivi samsung', 2, 1, '<p>sdddd</p>', 10, NULL, '<p>sdddđ</p>', '5456561', 'led-casper-50ug6100-(17)38.jpg', 0, NULL, NULL),
(7, 'tivi samsung', 18, 8, '<p>fffffffffffff</p>', 56, NULL, '<p>ffffffffffffff</p>', '5456561', 'led-casper-50ug6100-(17)16.jpg', 0, NULL, NULL),
(8, 'TiVi LG Siêu mỏng', 2, 9, '<p>Si&ecirc;u mỏng,48inch</p>', 10, NULL, '<h3>T&aacute;i hiện sắc đen ho&agrave;n hảo,&nbsp;m&agrave;u sắc rực rỡ, bắt mắt v&agrave; trung thực nhờ c&ocirc;ng nghệ&nbsp;m&agrave;n h&igrave;nh OLED - điểm ảnh tự ph&aacute;t s&aacute;ng</h3>', '11000000', 'tiveLG96.jpg', 0, NULL, NULL),
(9, 'TiVi Sony 2021', 2, 10, '<p>58ich, si&ecirc;u mỏng</p>', 12, NULL, '<p>Độ ph&acirc;n giải 4k</p>', '8000000', 'tivisony33.jfif', 0, NULL, NULL),
(11, 'Xiaomi Redmi 9A 2GB-32GB', 4, 3, '<p>Điện thoại th&ocirc;ng minh</p>', 12, NULL, '<p>Điện thoại th&ocirc;ng minh</p>', '2290000', 'xiaomi-redmi-9a-xanhla-600x600-200x20052 (1)55.png', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_shipping`
--

CREATE TABLE `tbl_shipping` (
  `shipping_id` int(10) UNSIGNED NOT NULL,
  `shipping_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_notes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tbl_shipping`
--

INSERT INTO `tbl_shipping` (`shipping_id`, `shipping_name`, `shipping_address`, `shipping_phone`, `shipping_email`, `shipping_notes`, `created_at`, `updated_at`) VALUES
(1, 'le duy khanh', 'can tho', '124587', 'khanh1508@gmail.com', 'dddddddddddddddd', NULL, NULL),
(2, 'le duy khanh', 'can tho', '124587555', 'khanh1508@gmail.com', 'sdddddd', NULL, NULL),
(3, 'le duy khanh', 'can tho', '124587', 'khanh1508@gmail.com', 'aadgsgfsfd', NULL, NULL),
(4, 'le duy khanh', 'can tho', '124587', 'khanh1508@gmail.com', 'ee', NULL, NULL),
(5, 'le duy khanh', 'can tho', '124587', 'khanh1508@gmail.com', 'ddd', NULL, NULL),
(6, 'le duy khanh', 'can tho', '124587', 'khanh1508@gmail.com', 'hàng giao nhanh', NULL, NULL),
(7, 'le duy khanh', 'can tho', '124587', 'khanh1508@gmail.com', 'hggg', NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_brand`
--
ALTER TABLE `tbl_brand`
  ADD PRIMARY KEY (`brand_id`);

--
-- Chỉ mục cho bảng `tbl_category_product`
--
ALTER TABLE `tbl_category_product`
  ADD PRIMARY KEY (`category_id`);

--
-- Chỉ mục cho bảng `tbl_customers`
--
ALTER TABLE `tbl_customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Chỉ mục cho bảng `tbl_feeship`
--
ALTER TABLE `tbl_feeship`
  ADD PRIMARY KEY (`fee_id`);

--
-- Chỉ mục cho bảng `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Chỉ mục cho bảng `tbl_order_details`
--
ALTER TABLE `tbl_order_details`
  ADD PRIMARY KEY (`order_details_id`);

--
-- Chỉ mục cho bảng `tbl_payment`
--
ALTER TABLE `tbl_payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Chỉ mục cho bảng `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`product_id`);

--
-- Chỉ mục cho bảng `tbl_shipping`
--
ALTER TABLE `tbl_shipping`
  ADD PRIMARY KEY (`shipping_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `tbl_brand`
--
ALTER TABLE `tbl_brand`
  MODIFY `brand_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `tbl_category_product`
--
ALTER TABLE `tbl_category_product`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `tbl_customers`
--
ALTER TABLE `tbl_customers`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `tbl_feeship`
--
ALTER TABLE `tbl_feeship`
  MODIFY `fee_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `tbl_order_details`
--
ALTER TABLE `tbl_order_details`
  MODIFY `order_details_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `tbl_payment`
--
ALTER TABLE `tbl_payment`
  MODIFY `payment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `product_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `tbl_shipping`
--
ALTER TABLE `tbl_shipping`
  MODIFY `shipping_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
