/* Database init script for SQLite */

CREATE TABLE skill(
    `key` TEXT PRIMARY KEY,
    `value` TEXT
);

CREATE TABLE imports(
    `table` TEXT PRIMARY KEY,
    `date_imported` INTEGER,
    `dataset_count` INTEGER,
    `time_taken` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE category(
    `id` INTEGER PRIMARY KEY,
    `type` TEXT,
    `section` TEXT,
    `name` TEXT,
    `is_game_related` BIT,
    `is_mining` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER,
    `combined_name` TEXT
);

CREATE TABLE category_attribute(
    `id` INTEGER PRIMARY KEY,
    `id_category` INTEGER,
    `name` TEXT,
    `category_name` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE city(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_moon` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `code` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `is_monitored` BIT,
    `is_armistice` BIT,
    `is_landable` BIT,
    `is_decommissioned` BIT,
    `has_quantum_marker` BIT,
    `has_trade_terminal` BIT,
    `has_habitation` BIT,
    `has_refinery` BIT,
    `has_cargo_center` BIT,
    `has_clinic` BIT,
    `has_food` BIT,
    `has_shops` BIT,
    `has_refuel` BIT,
    `has_repair` BIT,
    `has_gravity` BIT,
    `has_loading_dock` BIT,
    `has_docking_port` BIT,
    `has_freight_elevator` BIT,
    `pad_types` TEXT,
    `wiki` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE commodity(
    `id` INTEGER PRIMARY KEY,
    `id_parent` INTEGER,
    `name` TEXT,
    `code` TEXT,
    `slug` TEXT,
    `kind` TEXT,
    `weight_scu` INTEGER,
    `price_buy` REAL,
    `price_sell` REAL,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_raw` BIT,
    `is_refined` BIT,
    `is_mineral` BIT,
    `is_harvestable` BIT,
    `is_buyable` BIT,
    `is_sellable` BIT,
    `is_temporary` BIT,
    `is_illegal` BIT,
    `is_fuel` BIT,
    `wiki` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `is_blacklisted` BIT,
    `last_import_run_id` INTEGER
);

CREATE TABLE commodity_alert(
    `id_commodity` INTEGER,
    `id_terminal` INTEGER,
    `price_buy` INTEGER,
    `price_sell` INTEGER,
    `scu_buy` REAL,
    `scu_sell` REAL,
    `status_buy` INTEGER,
    `status_sell` INTEGER,
    `date_added` INTEGER,
    `game_version` TEXT,
    `commodity_name` TEXT,
    `commodity_code` TEXT,
    `commodity_slug` TEXT,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `space_station_name` TEXT,
    `outpost_name` TEXT,
    `city_name` TEXT,
    `faction_name` TEXT,
    `terminal_name` TEXT,
    `terminal_code` TEXT,
    `terminal_slug` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE commodity_price(
    `id` INTEGER PRIMARY KEY,
    `id_commodity` INTEGER,
    `id_terminal` INTEGER,
    `price_buy` REAL,
    `price_buy_avg` REAL,
    `price_sell` REAL,
    `price_sell_avg` REAL,
    `scu_buy` REAL,
    `scu_buy_avg` REAL,
    `scu_sell_stock` REAL,
    `scu_sell_stock_avg` REAL,
    `scu_sell` REAL,
    `scu_sell_avg` REAL,
    `status_buy` INTEGER,
    `status_sell` INTEGER,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `commodity_name` TEXT,
    `commodity_code` TEXT,
    `commodity_slug` TEXT,
    `terminal_name` TEXT,
    `terminal_code` TEXT,
    `terminal_slug` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE commodity_status(
    `code` INTEGER,
    `name` TEXT,
    `name_short` TEXT,
    `name_abbr` TEXT,
    `percentage` TEXT,
    `colors` TEXT,
    `is_buy` BIT,
    `last_import_run_id` INTEGER
);

CREATE TABLE company(
    `id` INTEGER PRIMARY KEY,
    `id_faction` INTEGER,
    `name` TEXT,
    `nickname` TEXT,
    `wiki` TEXT,
    `industry` TEXT,
    `is_item_manufacturer` BIT,
    `is_vehicle_manufacturer` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE faction(
    `id` INTEGER PRIMARY KEY,
    `ids_star_systems` TEXT,
    `ids_factions_friendly` TEXT,
    `ids_factions_hostile` TEXT,
    `name` TEXT,
    `wiki` TEXT,
    `is_piracy` BIT,
    `is_bounty_hunting` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE fuel_price(
    `id` INTEGER PRIMARY KEY,
    `id_commodity` INTEGER,
    `id_terminal` INTEGER,
    `price_buy` REAL,
    `price_buy_avg` REAL,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `commodity_name` TEXT,
    `commodity_code` TEXT,
    `commodity_slug` TEXT,
    `terminal_name` TEXT,
    `terminal_code` TEXT,
    `terminal_slug` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE game_version(
    `id` INTEGER PRIMARY KEY,
    `live` TEXT,
    `ptu` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE item(
    `id` INTEGER PRIMARY KEY,
    `id_parent` INTEGER,
    `id_category` INTEGER,
    `id_company` INTEGER,
    `id_vehicle` INTEGER,
    `name` TEXT,
    `section` TEXT,
    `category` TEXT,
    `vehicle_name` TEXT,
    `company_name` TEXT,
    `slug` TEXT,
    `uuid` TEXT,
    `url_store` TEXT,
    `is_exclusive_pledge` BIT,
    `is_exclusive_subscriber` BIT,
    `is_exclusive_concierge` BIT,
    `notification` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE item_price(
    `id` INTEGER PRIMARY KEY,
    `id_item` INTEGER,
    `id_terminal` INTEGER,
    `id_category` INTEGER,
    `price_buy` REAL,
    `price_sell` REAL,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `item_name` TEXT,
    `item_uuid` TEXT,
    `terminal_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE item_attribute(
    `id` INTEGER PRIMARY KEY,
    `id_item` INTEGER,
    `id_category` INTEGER,
    `id_category_attribute` INTEGER,
    `category_name` TEXT,
    `item_name` TEXT,
    `attribute_name` TEXT,
    `value` TEXT,
    `unit` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE jurisdiction(
    `id` INTEGER PRIMARY KEY,
    `id_faction` INTEGER,
    `name` TEXT,
    `nickname` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `wiki` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `faction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE moon(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `name_origin` TEXT,
    `code` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE orbit(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `name_origin` TEXT,
    `code` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `is_lagrange` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE orbit_distance(
    `id` INTEGER PRIMARY KEY,
--    `id_star_system` INTEGER,
    `id_star_system_origin` INTEGER,
    `id_star_system_destination` INTEGER,
    `id_orbit_origin` INTEGER,
    `id_orbit_destination` INTEGER,
    `distance` REAL,
    `game_version` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `orbit_origin_name` TEXT,
    `orbit_destination_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE outpost(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_moon` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `nickname` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `is_monitored` BIT,
    `is_armistice` BIT,
    `is_landable` BIT,
    `is_decommissioned` BIT,
    `has_quantum_marker` BIT,
    `has_trade_terminal` BIT,
    `has_habitation` BIT,
    `has_refinery` BIT,
    `has_cargo_center` BIT,
    `has_clinic` BIT,
    `has_food` BIT,
    `has_shops` BIT,
    `has_refuel` BIT,
    `has_repair` BIT,
    `has_gravity` BIT,
    `has_loading_dock` BIT,
    `has_docking_port` BIT,
    `has_freight_elevator` BIT,
    `pad_types` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE planet(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `name_origin` TEXT,
    `code` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `is_lagrange` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE poi(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_moon` INTEGER,
    `id_space_station` INTEGER,
    `id_city` INTEGER,
    `id_outpost` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `nickname` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `is_monitored` BIT,
    `is_armistice` BIT,
    `is_landable` BIT,
    `is_decommissioned` BIT,
    `has_quantum_marker` BIT,
    `has_trade_terminal` BIT,
    `has_habitation` BIT,
    `has_refinery` BIT,
    `has_cargo_center` BIT,
    `has_clinic` BIT,
    `has_food` BIT,
    `has_shops` BIT,
    `has_refuel` BIT,
    `has_repair` BIT,
    `has_gravity` BIT,
    `has_loading_dock` BIT,
    `has_docking_port` BIT,
    `has_freight_elevator` BIT,
    `pad_types` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `space_station_name` TEXT,
    `outpost_name` TEXT,
    `city_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE refinery_audit(
    `id` INTEGER PRIMARY KEY,
    `id_commodity` INTEGER,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_moon` INTEGER,
    `id_city` INTEGER,
    `id_outpost` INTEGER,
    `id_poi` INTEGER,
    `id_faction` INTEGER,
    `id_terminal` INTEGER,
    `yield` INTEGER,
    `capacity` INTEGER,
    `method` INTEGER,
    `quantity` INTEGER,
    `quantity_yield` INTEGER,
    `quantity_inert` INTEGER,
    `total_cost` INTEGER,
    `total_time` INTEGER,
    `date_added` INTEGER,
    `date_reported` INTEGER,
    `game_version` TEXT,
    `datarunner` TEXT,
    `commodity_name` TEXT,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `space_station_name` TEXT,
    `city_name` TEXT,
    `outpost_name` TEXT,
    `terminal_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE refinery_method(
    `id` INTEGER PRIMARY KEY,
    `name` TEXT,
    `code` TEXT,
    `rating_yield` INTEGER,
    `rating_cost` INTEGER,
    `rating_speed` INTEGER,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE space_station(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_moon` INTEGER,
    `id_city` INTEGER,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `nickname` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `is_monitored` BIT,
    `is_armistice` BIT,
    `is_landable` BIT,
    `is_decommissioned` BIT,
    `is_lagrange` BIT,
    `has_quantum_marker` BIT,
    `has_trade_terminal` BIT,
    `has_habitation` BIT,
    `has_refinery` BIT,
    `has_cargo_center` BIT,
    `has_clinic` BIT,
    `has_food` BIT,
    `has_shops` BIT,
    `has_refuel` BIT,
    `has_repair` BIT,
    `has_gravity` BIT,
    `has_loading_dock` BIT,
    `has_docking_port` BIT,
    `has_freight_elevator` BIT,
    `pad_types` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `city_name` TEXT,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE star_system(
    `id` INTEGER PRIMARY KEY,
    `id_faction` INTEGER,
    `id_jurisdiction` INTEGER,
    `name` TEXT,
    `code` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default` BIT,
    `wiki` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `faction_name` TEXT,
    `jurisdiction_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE terminal(
    `id` INTEGER PRIMARY KEY,
    `id_star_system` INTEGER,
    `id_planet` INTEGER,
    `id_orbit` INTEGER,
    `id_moon` INTEGER,
    `id_space_station` INTEGER,
    `id_outpost` INTEGER,
    `id_poi` INTEGER,
    `id_city` INTEGER,
    `id_faction` INTEGER,
    `id_company` INTEGER,
    `name` TEXT,
    `nickname` TEXT,
    `code` TEXT,
    `type` TEXT,
    `is_available` BIT,
    `is_available_live` BIT,
    `is_visible` BIT,
    `is_default_system` BIT,
    `is_affinity_influenceable` BIT,
    `is_habitation` BIT,
    `is_refinery` BIT,
    `is_cargo_center` BIT,
    `is_medical` BIT,
    `is_food` BIT,
    `is_shop_fps` BIT,
    `is_shop_vehicle` BIT,
    `is_refuel` BIT,
    `is_repair` BIT,
    `is_nqa` BIT,
    `is_player_owned` BIT,
    `is_auto_load` BIT,
    `has_loading_dock` BIT,
    `has_docking_port` BIT,
    `has_freight_elevator` BIT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `star_system_name` TEXT,
    `planet_name` TEXT,
    `orbit_name` TEXT,
    `moon_name` TEXT,
    `space_station_name` TEXT,
    `outpost_name` TEXT,
    `city_name` TEXT,
    `faction_name` TEXT,
    `company_name` TEXT,
    `max_container_size` INTEGER,
    `is_blacklisted` BIT,
    `last_import_run_id` INTEGER
);

CREATE TABLE vehicle(
    `id` INTEGER PRIMARY KEY,
    `id_company` INTEGER,
    `id_parent` INTEGER,
    `ids_vehicles_loaners` TEXT,
    `name` TEXT,
    `name_full` TEXT,
    `slug` TEXT,
    `uuid` TEXT,
    `scu` INTEGER,
    `crew` TEXT,
    `mass` INTEGER,
    `width` INTEGER,
    `height` INTEGER,
    `length` INTEGER,
    `fuel_quantum` INTEGER,
    `fuel_hydrogen` INTEGER,
    `container_sizes` TEXT,
    `is_addon` BIT,
    `is_boarding` BIT,
    `is_bomber` BIT,
    `is_cargo` BIT,
    `is_carrier` BIT,
    `is_civilian` BIT,
    `is_concept` BIT,
    `is_construction` BIT,
    `is_datarunner` BIT,
    `is_docking` BIT,
    `is_emp` BIT,
    `is_exploration` BIT,
    `is_ground_vehicle` BIT,
    `is_hangar` BIT,
    `is_industrial` BIT,
    `is_interdiction` BIT,
    `is_loading_dock` BIT,
    `is_medical` BIT,
    `is_military` BIT,
    `is_mining` BIT,
    `is_passenger` BIT,
    `is_qed` BIT,
    `is_racing` BIT,
    `is_refinery` BIT,
    `is_refuel` BIT,
    `is_repair` BIT,
    `is_research` BIT,
    `is_salvage` BIT,
    `is_scanning` BIT,
    `is_science` BIT,
    `is_showdown_winner` BIT,
    `is_spaceship` BIT,
    `is_starter` BIT,
    `is_stealth` BIT,
    `is_tractor_beam` BIT,
    `url_store` TEXT,
    `url_brochure` TEXT,
    `url_hotsite` TEXT,
    `url_video` TEXT,
    `url_photos` TEXT,
    `pad_type` TEXT,
    `game_version` TEXT,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `company_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE vehicle_purchase_price(
    `id` INTEGER PRIMARY KEY,
    `id_vehicle` INTEGER,
    `id_terminal` INTEGER,
    `price_buy` REAL,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `vehicle_name` TEXT,
    `terminal_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE vehicle_rental_price(
    `id` INTEGER PRIMARY KEY,
    `id_vehicle` INTEGER,
    `id_terminal` INTEGER,
    `price_rent` REAL,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `vehicle_name` TEXT,
    `terminal_name` TEXT,
    `last_import_run_id` INTEGER
);

CREATE TABLE commodity_route(
    `id` INTEGER PRIMARY KEY,
    `id_commodity` INTEGER,
    `id_star_system_origin` INTEGER,
    `id_star_system_destination` INTEGER,
    `id_planet_origin` INTEGER,
    `id_planet_destination` INTEGER,
    `id_orbit_origin` INTEGER,
    `id_orbit_destination` INTEGER,
    `id_terminal_origin` INTEGER,
    `id_terminal_destination` INTEGER,
    `id_faction_origin` INTEGER,
    `id_faction_destination` INTEGER,
    `code` TEXT,
    `price_origin` REAL,
    `price_origin_users` REAL,
    `price_origin_users_rows` REAL,
    `price_destination` REAL,
    `price_destination_users` REAL,
    `price_destination_users_rows` REAL,
    `price_margin` REAL,
    `scu_origin` REAL,
    `scu_origin_users` REAL,
    `scu_origin_users_rows` REAL,
    `scu_destination` REAL,
    `scu_destination_users` REAL,
    `scu_destination_users_rows` REAL,
    `scu_margin` REAL,
    `volatility_origin` REAL,
    `volatility_destination` REAL,
    `status_origin` INTEGER,
    `status_destination` INTEGER,
    `investment` REAL,
    `profit` REAL,
    `distance` REAL,
    `score` INTEGER,
    `has_docking_port_origin` BIT,
    `has_docking_port_destination` BIT,
    `has_freight_elevator_origin` BIT,
    `has_freight_elevator_destination` BIT,
    `has_loading_dock_origin` BIT,
    `has_loading_dock_destination` BIT,
    `has_refuel_origin` BIT,
    `has_refuel_destination` BIT,
    `has_cargo_center_origin` BIT,
    `has_cargo_center_destination` BIT,
    `has_quantum_marker_origin` BIT,
    `has_quantum_marker_destination` BIT,
    `is_monitored_origin` BIT,
    `is_monitored_destination` BIT,
    `is_space_station_origin` BIT,
    `is_space_station_destination` BIT,
    `is_on_ground_origin` BIT,
    `is_on_ground_destination` BIT,
    `commodity_name` TEXT,
    `commodity_code` TEXT,
    `commodity_slug` TEXT,
    `origin_star_system_name` TEXT,
    `origin_planet_name` TEXT,
    `origin_orbit_name` TEXT,
    `origin_terminal_name` TEXT,
    `origin_terminal_code` TEXT,
    `origin_terminal_slug` TEXT,
    `origin_terminal_is_player_owned` BIT,
    `origin_faction_name` TEXT,
    `destination_star_system_name` TEXT,
    `destination_planet_name` TEXT,
    `destination_orbit_name` TEXT,
    `destination_terminal_name` TEXT,
    `destination_terminal_code` TEXT,
    `destination_terminal_slug` TEXT,
    `destination_terminal_is_player_owned` BIT,
    `destination_faction_name` TEXT,
    `date_added` INTEGER,
    `last_import_run_id` INTEGER
);

CREATE TABLE commodity_raw_price(
    `id` INTEGER PRIMARY KEY,
    `id_commodity` INTEGER,
    `id_terminal` INTEGER,
    `price_sell` REAL,
    `price_sell_avg` REAL,
    `date_added` INTEGER,
    `date_modified` INTEGER,
    `commodity_name` TEXT,
    `commodity_code` TEXT,
    `commodity_slug` TEXT,
    `terminal_name` INTEGER,
    `terminal_code` INTEGER,
    `terminal_slug` INTEGER,
    `last_import_run_id` INTEGER
);
