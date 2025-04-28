CREATE TABLE `brands` (
  `id` uuid PRIMARY KEY,
  `name` varchar(50) UNIQUE,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `products` (
  `id` uuid PRIMARY KEY,
  `name` varchar(50) UNIQUE,
  `description` text,
  `brand_id` uuid,
  `base_price` decimal(5,2) DEFAULT 0,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `product_images` (
  `id` uuid PRIMARY KEY,
  `product_id` uuid,
  `file_path` varchar(50),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `categories` (
  `id` uuid PRIMARY KEY,
  `name` varchar(50) UNIQUE,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `product_categories` (
  `id` uuid PRIMARY KEY,
  `product_id` uuid,
  `category_id` uuid
);

CREATE TABLE `product_items` (
  `id` uuid PRIMARY KEY,
  `product_id` uuid,
  `product_category_id` uuid,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `size_categories` (
  `id` uuid PRIMARY KEY,
  `category` varchar(50) UNIQUE,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `size_options` (
  `id` uuid PRIMARY KEY,
  `size_category_id` uuid,
  `option` varchar(50),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `colors` (
  `id` uuid PRIMARY KEY,
  `color` varchar(50) UNIQUE,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `product_variations` (
  `id` uuid PRIMARY KEY,
  `product_id` uuid,
  `product_category_id` uuid,
  `product_item_id` uuid,
  `size_category_id` uuid,
  `size_option_id` uuid,
  `color_id` uuid,
  `file_path` varchar(50),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `attribute_categories` (
  `id` uuid PRIMARY KEY,
  `attribute_category` varchar(50) UNIQUE,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `attribute_types` (
  `id` uuid PRIMARY KEY,
  `attribute_category_id` uuid,
  `attribute_type` varchar(50),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `attributes` (
  `id` uuid PRIMARY KEY,
  `attribute_category_id` uuid,
  `attribute_type_id` uuid,
  `attribute` varchar(50),
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `product_attributes` (
  `id` uuid PRIMARY KEY,
  `product_id` uuid,
  `product_category_id` uuid,
  `product_item_id` uuid,
  `product_variation_id` uuid,
  `attribute_category_id` uuid,
  `attribute_type_id` uuid,
  `attribute_id` uuid,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE UNIQUE INDEX `product_categories_index_0` ON `product_categories` (`product_id`, `category_id`);

CREATE UNIQUE INDEX `product_items_index_1` ON `product_items` (`product_id`, `product_category_id`);

CREATE UNIQUE INDEX `size_options_index_2` ON `size_options` (`size_category_id`, `option`);

CREATE UNIQUE INDEX `product_variations_index_3` ON `product_variations` (`product_item_id`, `size_option_id`, `color_id`);

CREATE UNIQUE INDEX `attribute_types_index_4` ON `attribute_types` (`attribute_category_id`, `attribute_type`);

CREATE UNIQUE INDEX `attributes_index_5` ON `attributes` (`attribute_category_id`, `attribute_type_id`);

CREATE UNIQUE INDEX `product_attributes_index_6` ON `product_attributes` (`product_variation_id`, `attribute_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

ALTER TABLE `product_images` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_categories` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_categories` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `product_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_items` ADD FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`);

ALTER TABLE `size_options` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_categories` (`id`);

ALTER TABLE `product_variations` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_variations` ADD FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`);

ALTER TABLE `product_variations` ADD FOREIGN KEY (`product_item_id`) REFERENCES `product_items` (`id`);

ALTER TABLE `product_variations` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_categories` (`id`);

ALTER TABLE `product_variations` ADD FOREIGN KEY (`size_option_id`) REFERENCES `size_options` (`id`);

ALTER TABLE `product_variations` ADD FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`);

ALTER TABLE `attribute_types` ADD FOREIGN KEY (`attribute_category_id`) REFERENCES `attribute_categories` (`id`);

ALTER TABLE `attributes` ADD FOREIGN KEY (`attribute_category_id`) REFERENCES `attribute_categories` (`id`);

ALTER TABLE `attributes` ADD FOREIGN KEY (`attribute_type_id`) REFERENCES `attribute_types` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`product_item_id`) REFERENCES `product_items` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`attribute_category_id`) REFERENCES `attribute_categories` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`attribute_type_id`) REFERENCES `attribute_types` (`id`);

ALTER TABLE `product_attributes` ADD FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`);
