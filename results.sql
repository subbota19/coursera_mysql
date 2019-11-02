use test
set names utf8;

-- 1. Выбрать все товары (все поля)
select * from product

-- 2. Выбрать названия всех автоматизированных складов
 select name from store where is_automated <> 0

-- 3. Посчитать общую сумму в деньгах всех продаж
 select sum(total) as products_sum from sale;

-- 4. Получить уникальные store_id всех складов, с которых была хоть одна продажа
select distinct(store_id) as all_sale_id from sale;

-- 5. Получить уникальные store_id всех складов, с которых не было ни одной продажи
 select distinct(store.store_id) from store left join sale on store.store_id=sale.store_id where sale.store_id is NULL;

-- 6. Получить для каждого товара название и среднюю стоимость единицы товара avg(total/quantity), если товар не продавался, он не попадает в отчет.
select product.name,avg(sale.total/sale.quantity) avg_sale from sale left join product on product.product_id=sale.product_id group by product.name ;

-- 7. Получить названия всех продуктов, которые продавались только с единственного склада
 select product.name from product join sale using(product_id) group by product.name having count(distinct sale.store_id)=1;

-- 8. Получить названия всех складов, с которых продавался только один продукт
 select store.name from store join sale using(store_id) group by store.name having count(distinct sale.product_id)=1;

-- 9. Выберите все ряды (все поля) из продаж, в которых сумма продажи (total) максимальна (равна максимальной из всех встречающихся)
select * from sale where total=(select max(total) from sale);

-- 10. Выведите дату самых максимальных продаж, если таких дат несколько, то самую раннюю из них
 select min(date) from sale as min_date where total=(select max(total) from sale);
