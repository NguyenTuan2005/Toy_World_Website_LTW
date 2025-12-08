
insert into roles(id,role_name)
values (2,'ROLE_ADMIN'),(1,'ROLE_USER');

INSERT INTO locations (id,address, province) VALUES
  (1,'12 Nguyen Hue', 'HCM'),
  (2,'45 Tran Hung Dao', 'Hanoi'),
  (3,'22 Vo Van Kiet', 'Danang'),
  (4,'89 Le Loi', 'Hue'),
  (5,'77 Cach Mang Thang 8', 'Can Tho');

INSERT INTO users (id,first_name, last_name, phone, gender, password, email, location_id)
VALUES
(1,'User1', 'Test', '0900000001', 'Male', '123456', 'user1@gmail.com', 1),
(2,'User2', 'Test', '0900000002', 'Female', '123456', 'user2@gmail.com', 2),
(3,'User3', 'Test', '0900000003', 'Male', '123456', 'user3@gmail.com', 3),
(4,'User4', 'Test', '0900000004', 'Female', '123456', 'user4@gmail.com', 4),
(5,'User5', 'Test', '0900000005', 'Male', '123456', 'user5@gmail.com', 5),
(6,'User6', 'Test', '0900000006', 'Female', '123456', 'user6@gmail.com', 1),
(7,'User7', 'Test', '0900000007', 'Male', '123456', 'user7@gmail.com', 2),
(8,'User8', 'Test', '0900000008', 'Female', '123456', 'user8@gmail.com', 3),
(9,'User9', 'Test', '0900000009', 'Male', '123456', 'user9@gmail.com', 4),
(10,'User10', 'Test', '0900000010', 'Female', '123456', 'user10@gmail.com', 5),
(11,'User11', 'Test', '0900000011', 'Male', '123456', 'user11@gmail.com', 1),
(12,'User12', 'Test', '0900000012', 'Female', '123456', 'user12@gmail.com', 2),
(13,'User13', 'Test', '0900000013', 'Male', '123456', 'user13@gmail.com', 3),
(14,'User14', 'Test', '0900000014', 'Female', '123456', 'user14@gmail.com', 4),
(15,'User15', 'Test', '0900000015', 'Male', '123456', 'user15@gmail.com', 5),
(16,'User16', 'Test', '0900000016', 'Female', '123456', 'user16@gmail.com', 1),
(17,'User17', 'Test', '0900000017', 'Male', '123456', 'user17@gmail.com', 2),
(18,'User18', 'Test', '0900000018', 'Female', '123456', 'user18@gmail.com', 3),
(19,'User19', 'Test', '0900000019', 'Male', '123456', 'user19@gmail.com', 4),
(20,'User20', 'Test', '0900000020', 'Female', '123456', 'user20@gmail.com', 5),
(21,'User21', 'Test', '0900000021', 'Male', '123456', 'user21@gmail.com', 1),
(22,'User22', 'Test', '0900000022', 'Female', '123456', 'user22@gmail.com', 2),
(23,'User23', 'Test', '0900000023', 'Male', '123456', 'user23@gmail.com', 3),
(24,'User24', 'Test', '0900000024', 'Female', '123456', 'user24@gmail.com', 4),
(25,'User25', 'Test', '0900000025', 'Male', '123456', 'user25@gmail.com', 5),
(26,'User26', 'Test', '0900000026', 'Female', '123456', 'user26@gmail.com', 1),
(27,'User27', 'Test', '0900000027', 'Male', '123456', 'user27@gmail.com', 2),
(28,'User28', 'Test', '0900000028', 'Female', '123456', 'user28@gmail.com', 3),
(29,'User29', 'Test', '0900000029', 'Male', '123456', 'user29@gmail.com', 4),
(30,'User30', 'Test', '0900000030', 'Female', '123456', 'user30@gmail.com', 5),
(31,'User31', 'Test', '0900000031', 'Male', '123456', 'user31@gmail.com', 1),
(32,'User32', 'Test', '0900000032', 'Female', '123456', 'user32@gmail.com', 2),
(33,'User33', 'Test', '0900000033', 'Male', '123456', 'user33@gmail.com', 3),
(34,'User34', 'Test', '0900000034', 'Female', '123456', 'user34@gmail.com', 4),
(35,'User35', 'Test', '0900000035', 'Male', '123456', 'user35@gmail.com', 5),
(36,'User36', 'Test', '0900000036', 'Female', '123456', 'user36@gmail.com', 1),
(37,'User37', 'Test', '0900000037', 'Male', '123456', 'user37@gmail.com', 2),
(38,'User38', 'Test', '0900000038', 'Female', '123456', 'user38@gmail.com', 3),
(39,'User39', 'Test', '0900000039', 'Male', '123456', 'user39@gmail.com', 4),
(40,'User40', 'Test', '0900000040', 'Female', '123456', 'user40@gmail.com', 5),
(41,'User41', 'Test', '0900000041', 'Male', '123456', 'user41@gmail.com', 1),
(42,'User42', 'Test', '0900000042', 'Female', '123456', 'user42@gmail.com', 2),
(43,'User43', 'Test', '0900000043', 'Male', '123456', 'user43@gmail.com', 3),
(44,'User44', 'Test', '0900000044', 'Female', '123456', 'user44@gmail.com', 4),
(45,'User45', 'Test', '0900000045', 'Male', '123456', 'user45@gmail.com', 5),
(46,'User46', 'Test', '0900000046', 'Female', '123456', 'user46@gmail.com', 1),
(47,'User47', 'Test', '0900000047', 'Male', '123456', 'user47@gmail.com', 2),
(48,'User48', 'Test', '0900000048', 'Female', '123456', 'user48@gmail.com', 3),
(49,'User49', 'Test', '0900000049', 'Male', '123456', 'user49@gmail.com', 4),
(50,'User50', 'Test', '0900000050', 'Female', '123456', 'user50@gmail.com', 5);
INSERT INTO user_roles (user_id, role_id) VALUES
  (1,1),(2,1),(3,1),(4,1),(5,1),
  (6,1),(7,1),(8,1),(9,1),(10,1),
  (11,1),(12,1),(13,1),(14,1),(15,1),
  (16,1),(17,1),(18,1),(19,1),(20,1),
  (21,1),(22,1),(23,1),(24,1),(25,1),
  (26,1),(27,1),(28,1),(29,1),(30,1),
  (31,1),(32,1),(33,1),(34,1),(35,1),
  (36,1),(37,1),(38,1),(39,1),(40,1),
  (41,1),(42,1),(43,1),(44,1),(45,1),
  (46,1),(47,1),(48,1),(49,1),(50,1);
-- handbook

INSERT INTO category_hbs (`id`, `name`, `is_active`) VALUES
                                                         (1, 'Đồ chơi xếp hình', 1),
                                                         (2, 'Đồ chơi lắp ráp', 1),
                                                         (3, 'Đồ chơi điều khiển', 1),
                                                         (4, 'Búp bê', 1),
                                                         (5, 'Mô hình ô tô', 1),
                                                         (6, 'Đồ chơi giáo dục', 1),
                                                         (7, 'Đồ chơi thể thao', 1),
                                                         (8, 'Đồ chơi ngoài trời', 1),
                                                         (9, 'Đồ chơi điện tử', 1),
                                                         (10, 'Đồ chơi gỗ', 1);


insert into handbooks(id,user_id,title,views,status)
values (1,1,'IWAYA đồ chơi thú cưng 2025: Mô hình động vật mini đáng yêu cho bé!',1,'POSTED');

INSERT INTO paragraphs (id,header, description, image_path, image_description, display_index, handbook_id)
VALUES (1,'IWAYA đồ chơi thú cưng 2025: Mô hình động vật mini đáng yêu cho bé!','not found','https://www.mykingdom.com.vn/cdn/shop/articles/iwaya-do-choi-thu-cung-2025.jpg?v=1764727470','hinh em be',0)
,(2,'Tại sao IWAYA đồ chơi thú cưng 2025 được ba mẹ săn lùng ráo riết?','Trong thế giới đồ chơi thú cưng hiện đại, IWAYA đồ chơi thú cưng 2025 đang tạo ra một cơn sốt không chỉ với các bé mà còn được ba mẹ săn đón nhiệt tình. Đã nhiều năm qua, các sản phẩm IWAYA luôn là lựa chọn hàng đầu của các gia đình, và trong năm 2025 sự hấp dẫn của chúng ngày càng gia tăng. Vậy đâu là lý do khiến IWAYA trở thành món quà không thể thiếu cho bé? IWAYA nổi tiếng là thương hiệu đồ chơi thú cưng hơn 100 năm tuổi của Nhật Bản, được thiết kế để kích thích sự hứng thú và tương tác ở trẻ em. Chúng có các tính năng nổi bật như: Tương tác đa dạng: Tùy thuộc vào mẫu sản phẩm, đồ chơi có thể di chuyển, lắc lư đuôi, gật gù đầu, phát ra tiếng kêu (như tiếng sủa, meo meo, hót) vui nhộn. Cảm biến chạm: Nhiều mẫu có tích hợp cảm biến chạm ở đầu hoặc lưng, cho phép thú cưng phản ứng khi được vuốt ve hoặc ôm ấp. Điều khiển từ xa: Một số mẫu như cún con có dây điều khiển, cho phép trẻ dẫn thú cưng đi dạo, mô phỏng trải nghiệm dắt thú đi chơi thực sự.Chất liệu mềm mại: Thú bông được làm từ chất liệu vải bông mềm mại, an toàn cho trẻ em từ 3 trở lên. Thiết kế đáng yêu: Các sản phẩm có hình dáng của nhiều loài động vật khác nhau như chó (Chihuahua, Toy Poodle, Husky), mèo Ba Tư, chim cánh cụt, gấu trúc… với vẻ ngoài dễ thương, thân thiện. Vì vậy, không lý do gì mà ba mẹ không rước đồ chơi thú cưng thông minh này về làm quà cho bé yêu của mình ngay!','','',1,1)
,(3,'Mô hình thú cưng IWAYA đang được yêu thích','Cute vô đối với chú Chim Cánh Cụt Con Hồng sành điệu! Đây không chỉ là đồ chơi, mà là một "pet ảo" siêu xịn. Em nó sở hữu lớp lông mềm như mây và các động tác di chuyển, đập cánh, kêu y hệt chim cánh cụt thật. Chỉ cần vỗ nhẹ vào đầu là kêu luôn, không cần pin vẫn tương tác! Rinh ngay em này để con có thêm người bạn cực chill.','https://www.mykingdom.com.vn/cdn/shop/files/chim-canh-cut-con-hong-iwaya-3243-2-vn-js_3.jpg?v=1741943727&width=1946','no',2,1)
,(4,'Baby Capybara ','Gặp gỡ Capybara – "nhà ngoại giao" hot nhất mạng xã hội! IWAYA đã tái hiện hoàn hảo chú chuột lang nước nổi tiếng này với lớp lông nâu mềm mịn. Em này biết di chuyển, kịt mũi và cử động đuôi sống động và kêu như Capybara thật. Đây là món đồ chơi phải có ngay để thể hiện gu chơi và có những khoảnh khắc tương tác siêu chữa lành.','https://www.mykingdom.com.vn/cdn/shop/files/baby-capybara-iwaya-3244-1vnjs_1.jpg?v=1736908605&width=1946','no',3,1);
