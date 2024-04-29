insert into customer values ('00437650', 'dsandoval@conncoll.edu', '832-801-8753', 'Danna', 'Sandoval');
insert into customer values ('00428232', 'atowle@conncoll.edu', '860-765-8080', 'Alexander', 'Towle');
insert into customer values ('00437651', 'tbecker@conncoll.edu', '860-123-4567', 'Tim', 'Becker');
insert into customer values ('00437652', 'cchung@conncoll.edu', '860-231-4500', 'Christine', 'Chung');
insert into customer values ('00437653', 'rpeitzsc@conncoll.edu', '860-231-1234', 'Robert', 'Peitzsch');
insert into customer values ('00437623', 'parker@conncoll.edu', '860-801-9999', 'Gary', 'Parker');
insert into trans values ('00000001', '11.10', '2233-0101-8123-4666', '2024-04-25','12', 'Bank St', 'New London', 'CT', '06320');
insert into trans values ('00000002', '3.50', '1234-5555-7893-0111', '2024-04-24','12', 'Bank St', 'New London', 'CT', '06320');
insert into trans values ('00000003', '23.50', '4243-7766-1414-0916', '2024-04-24','270', 'Mohegan Ave', 'New London', 'CT', '06320');
insert into trans values ('00000004', '15.00', '4312-7761-1413-0077', '2024-03-24','87', 'Main St', 'Boston', 'MA', '02112');
insert into trans values ('00000005', '2.94', '1234-5555-7893-0111', '2024-03-28','23', 'Travis St', 'Houston', 'TX', '77080');#t change cc num
insert into trans values ('00000006', '39.88', '8765-0909-4444-0333', '2024-04-01','123', 'High St', 'Boston', 'MA', '02120');
insert into trans values ('00000007', '9.95', '1234-5555-7893-0111', '2023-12-28','67', 'Bank St', 'Austin', 'TX', '78707');
insert into trans values ('00000008', '459.99', '0044-4246-9843-0509', '2024-01-31','57', 'Grove St', 'Portland', 'OR', '97035');
insert into trans values ('00000009', '11.00', '8609-6146-6666-4201', '2024-02-12','57', 'Grove St', 'Portland', 'OR', '97035');
insert into trans values ('000000010', '9.95', '4312-7761-1413-0077', '2023-10-23','87', 'Main St', 'Boston', 'MA', '02112');
insert into product values ('12345678', '012345678915', '2 Liter', 'Plastic', 'Soda', 'Coca-Cola');#bev,soda
insert into product values ('23456789', '089345543215', '1 Gallon', 'Plastic', 'Milk', 'Fairlife');
insert into product values ('87654321', '009123321435', '1 Liter', 'Plastic', 'Drinking Water', 'Aquafina');
insert into product values ('44433312', '012345678925', '500 mg', 'Plastic', 'Acetaminophen', 'Tylenol');
insert into product values ('00123476', '009876909095', '11 oz', 'Plastic', 'Dishwasher Pods', 'Cascade');
insert into product values ('12007645', '055050943218', '5 lb', 'Plastic', 'Poultry', 'Tyson');#food,meat,comestible
insert into product values ('87654321', '009123321435', '18 Fl Oz', 'Plastc', 'Dish Soap', 'Dawn Ultra');
insert into product values ('98788890', '009123321895', '5 lb', 'Stainless Steal', 'Blender', 'Magic Bullet'); #appliances
insert into product values ('56722123', '029123371435', '66 lb', 'Metal', 'Lawn Mower', 'PowerSmart');#gas
insert into product values ('87690012', '099123321435', '2 lb', 'Stainless Steal', 'Hand Mixer', 'KitchenAid');#electric
insert into product values ('12789887', '018123321435', '8 oz', 'Plastic', 'Shredded Lettuce', 'Marketside');#produce,food
insert into product values ('22990989', '009123321995', 'Medium', 'Cotton', 'T-Shirt', 'Hanes');#other
insert into store values ('12', 'Bank St', 'New London', 'CT', '06320', '06:00:00', '23:00:00');
insert into store values ('270', 'Mohegan Ave', 'New London', 'CT', '06320', '06:00:00', '23:00:00');
insert into store values ('87', 'Main St', 'Boston', 'MA', '02112', '07:00:00', '22:00:00');
insert into store values ('23', 'Travis St', 'Houston', 'TX', '77080', '06:00:00', '22:00:00');
insert into store values ('123', 'High St', 'Boston', 'MA', '02112', '08:00:00', '24:00:00');
insert into store values ('67', 'Bank St', 'Austin', 'TX', '78707', '08:00:00', '01:00:00');
insert into store values ('57', 'Grove St', 'Portland', 'OR', '97035', '00:00:00', '24:00:00');
insert into brand values ('Aquafina', 'PepsiCo');
insert into brand values ('Fairlife', 'The Coca-Cola Company');
insert into brand values ('Coca-Cola', 'The Coca-Cola Company');
insert into brand values ('Dawn Ultra', 'Procter & Gamble');
insert into brand values ('Cascade', 'Procter & Gamble');
insert into brand values ('Tylenol', 'Johnson & Johnson');
insert into brand values ('Tyson', 'Tyson Foods');
insert into brand values ('KitchenAid', 'Whirlpool Corporation');
insert into brand values ('Hanes', 'Hanesbrands Inc.');
insert into brand values ('Magic Bullet', 'Homeland Housewares');
insert into brand values ('PowerSmart', 'Amerisun Inc.');
insert into brand values ('Marketside', 'Walmart');
insert into vendor values ('PepsiCo', '860-961-4666');
insert into vendor values ('The Coca-Cola Company', '860-123-0333');
insert into vendor values ('Procter & Gamble', '860-324-9800');
insert into vendor values ('Johnson & Johnson', '860-866-4893');
insert into vendor values ('Tyson Foods', '860-666-6789');
insert into vendor values ('Whirlpool Corporation', '800-666-6789');
insert into vendor values ('Hanesbrands Inc.', '800-890-1234');
insert into vendor values ('Homeland Housewares', '800-456-4000');
insert into vendor values ('Amerisun Inc.', '800-889-1234');
insert into vendor values ('Walmart', '800-321-4567');
insert into member values ('00437650', '000020');
insert into member values ('00428232', '000320');
insert into member values ('00437651', '001203');
insert into inventory values ('12', 'Bank St', 'New London', 'CT', '06320', '12345678', '12', '3.50', '8', '10');
insert into inventory values ('12', 'Bank St', 'New London', 'CT', '06320', '12007645', '10', '7.60', '15', '20');
insert into inventory values ('270', 'Mohegan Ave', 'New London', 'CT', '06320', '44433312', '22', '11.00', '18', '35');
insert into inventory values ('270', 'Mohegan Ave', 'New London', 'CT', '06320', '00123476', '20', '12.50', '15', '30');
insert into inventory values ('87', 'Main St', 'Boston', 'MA', '02112', '22990989', '10', '15.00', '10', '20');
insert into inventory values ('87', 'Main St', 'Boston', 'MA', '02112', '87654321', '29', '9.95', '20', '40');
insert into inventory values ('23', 'Travis St', 'Houston', 'TX', '77080', '87654321', '20', '2.94', '8', '25');
insert into inventory values ('123', 'High St', 'Boston', 'MA', '02112', '87690012', '5', '39.88', '8', '10');
insert into inventory values ('67', 'Bank St', 'Austin', 'TX', '78707', '87654321', '34', '9.95', '16', '40');
insert into inventory values ('57', 'Grove St', 'Portland', 'OR', '97035', '56722123', '3', '459.99', '12', '10');
insert into inventory values ('57', 'Grove St', 'Portland', 'OR', '97035', '44433312', '22', '11.00', '18', '35');
insert into purchased values ('00000001', '00437650');#trans_id and cust_id
insert into purchased values ('00000002', '00437650');
insert into purchased values ('00000003', '00428232');
insert into purchased values ('00000004', '00437623');
insert into purchased values ('00000005', '00437651');
insert into purchased values ('00000006', '00437653');
insert into purchased values ('00000007', '00437651');
insert into purchased values ('00000008', '00437652');
insert into purchased values ('00000009', '00437652');
insert into purchased values ('00000010', '00437623');
insert into ordered values ('12345678', '00000001');#product_id and trans_id
insert into ordered values ('12007645', '00000001');
insert into ordered values ('12345678', '00000002');
insert into ordered values ('44433312', '00000003');
insert into ordered values ('00123476', '00000003');
insert into ordered values ('22990989', '00000004');
insert into ordered values ('87654321', '00000005');
insert into ordered values ('87690012', '00000006');
insert into ordered values ('87654321', '00000007');
insert into ordered values ('56722123', '00000008');
insert into ordered values ('44433312', '00000009');
insert into ordered values ('87654321', '00000010');
insert into sells_to values ('PepsiCo', '87', 'Main St', 'Boston', 'MA', '02112');
insert into sells_to values ('Hanesbrands Inc.', '87', 'Main St', 'Boston', 'MA', '02112');
insert into sells_to values ('The Coca-Cola Company', '12', 'Bank St', 'New London', 'CT', '06320');
insert into sells_to values ('Tyson Foods', '12', 'Bank St', 'New London', 'CT', '06320');
insert into sells_to values ('Johnson & Johnson', '270', 'Mohegan Ave', 'New London', 'CT', '06320');
insert into sells_to values ('Procter & Gamble', '270', 'Mohegan Ave', 'New London', 'CT', '06320');
insert into sells_to values ('Procter & Gamble', '87', 'Main St', 'Boston', 'MA', '02112');
insert into sells_to values ('Procter & Gamble', '23', 'Travis St', 'Houston', 'TX', '77080');
insert into sells_to values ('Whirlpool Corporation', '123', 'High St', 'Boston', 'MA', '02112');
insert into sells_to values ('Procter & Gamble', '67', 'Bank St', 'Austin', 'TX', '78707');
insert into sells_to values ('Amerisun Inc.', '57', 'Grove St', 'Portland', 'OR');
insert into sells_to values ('Johnson & Johnson', '57', 'Grove St', 'Portland', 'OR');
insert into appliance values ('98788890', 'Kitchen');#blender
insert into gas values ('56722123', '170cc');#lawn mower
insert into electric values('87690012', '200');#hand mixer
#calories for food are per serving
insert into food values('12007645', '200');#tyson chicken
insert into food values('12789887', '10');#lettuce
#calories for bevs are per serving
insert into beverage values('12345678', '140', '67');#soda
insert into beverage values('23456789', '103', '128');#1% fat milk
insert into beverage values('87654321', '0', '33');#water
insert into soda values('12345678', '0');
insert into water values ('87654321', 'Plain', '0');
insert into comestible values ('12007645', '0');#tyson chick
insert into comestible values ('12789887', '0');#lettuce
insert into meat values ('12007645', '0');
insert into produce values ('12789887', '1');
insert into other values ('22990989');
insert into cleaner values ('87654321', 'Dishwashing');#dish soap
insert into cleaner values ('00123476', 'Dishwashing');#dish pods
insert into dry_clean values ('00123476', '221');
insert into wet_clean values ('87654321', '100');
insert into drug values ('44433312', '500');