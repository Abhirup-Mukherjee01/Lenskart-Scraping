alter table [staging].[stg_productTable]
drop column imageUrls

alter table [staging].[stg_productTable]
drop column product_url

alter table [staging].[stg_productTable]
drop column brand_name, brand_logo

alter table [staging].[stg_productTable]
drop column prices, is_tbyb, tags, is_ditto, specifications, hashtagList

alter table [staging].[stg_productTable]
drop column classification, offerName, frameColorImage

alter table [staging].[stg_productTable]
drop column subCollection, subCollectionId, isCygnusEnabled, isCashbackApplicable

update [staging].[stg_productTable]
set totalNoOfRatings = ISNULL(totalNoOfRatings,0)

alter table [staging].stg_storeTable
drop column flag, store, si_store_id, status, store_open_status, brand_lk_jj


alter table [staging].stg_storeTable
drop column address_line_1,address_line_2, address_locality, address_landmark, address_city, address_state, address_country, wp_db_id, place_id, google_cid_g, flaberry_place_id_ur


alter table [staging].stg_storeTable
drop column latitude, longitude

alter table [staging].stg_storeTable
drop column fb_page_id, appointment_url, store_email, store_virtual_number

alter table [staging].stg_storeTable
drop column business_hours_openi, business_hours_closi, store_manager_name, store_manager_mobile, payment_types


alter table [staging].stg_storeTable
drop column  store_opening_date, store_size

alter table [staging].stg_storeTable
drop column  parking_options, single_interface_sto, slug, lenskart_store_page_, google_maps_url, google_search_url, google_review_url, bing, foursquare_url, yalwa_url, dealsnyou_url, magicpin_url, review_short_url, map_short_url


alter table [staging].stg_storeTable
drop column from_the_brand, labels, busy_hours, slightly_hours, serviceOptions, store_front_image, is_union_territory, created_at,updated_at



