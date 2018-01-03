-- -----------------------------------------------------
-- Table `settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `settings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `value` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `budgets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `budgets` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `type` ENUM('PLAN','EXP-INC') NOT NULL DEFAULT 'EXP-INC',
  `deleted` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `views`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `views` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `items` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM('PLAN','EXP','INC') NOT NULL DEFAULT 'EXP',
  `booked_at` DATE NOT NULL,
  `amount` DECIMAL NOT NULL,
  `comment` MEDIUMTEXT NULL,
  `deleted` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `budget_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_budget_idx` (`budget_id` ASC),
  CONSTRAINT `fk_budget`
    FOREIGN KEY (`budget_id`)
    REFERENCES `budgets` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tags` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `type` ENUM('PLAN','EXP','INC') NOT NULL DEFAULT 'EXP',
  `deleted` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `parent_id` INT UNSIGNED NULL,
  `budget_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_budget_idx` (`budget_id` ASC),
  INDEX `fk_parent_idx` (`parent_id` ASC),
  CONSTRAINT `fk_budget`
    FOREIGN KEY (`budget_id`)
    REFERENCES `budgets` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `tags` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `map_views_to_budgets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `map_views_to_budgets` (
  `view_id` INT UNSIGNED NOT NULL,
  `budget_id` INT UNSIGNED NOT NULL,
  INDEX `fk_budget_idx` (`budget_id` ASC),
  UNIQUE INDEX `u_view_budget` (`view_id` ASC, `budget_id` ASC),
  CONSTRAINT `fk_view`
    FOREIGN KEY (`view_id`)
    REFERENCES `views` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_budget`
    FOREIGN KEY (`budget_id`)
    REFERENCES `budgets` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `map_tags_to_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `map_tags_to_items` (
  `tag_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  INDEX `fk_item_id_idx` (`item_id` ASC),
  UNIQUE INDEX `u_tag_item` (`tag_id` ASC, `item_id` ASC),
  CONSTRAINT `fk_tag_id`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_id`
    FOREIGN KEY (`item_id`)
    REFERENCES `items` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
