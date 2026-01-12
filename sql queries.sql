create database sales_analysis;
use sales_analysis;
create table customers( customer_id varchar (20) primary key, customer_name varchar (100) , segment varchar (50) , region varchar (50) );
create table products( product_id varchar (20) primary key, category varchar (50) , sub_category varchar (50) , product_name 
varchar (50) );
use sales_analysis;
create table orders ( ship_mode varchar (50), segment varchar (50),countary varchar(50),city varchar(50), state varchar (50), postal_code varchar(20), region varchar (50), category varchar (50), sub_category varchar (50), sales decimal (10,4), quantity int , discount decimal (4,2), profit decimal(10,4) );
select * from orders;
desc orders;
# total sales & profit
select
sum(sales) as total_sales,
sum(profit) as total_profit from orders;
# category-wise sales
select category, sum(sales) as total_sales from orders group by category order by total_sales desc;
# region-wise profit 
select region, sum(profit) as total_profit from orders group by region order by total_profit desc;
#loss-making categories
select category, sum(profit) as total_profit from orders group by category having total_profit <0;
#high discount vs profit check 
select discount, sum(profit) as total_profit from orders group by discount order by discount;
use sales_analysis;
# adding new column
alter table orders add discount_flag varchar(20) ;
desc orders;
use sales_analysis;
update orders set  discount_flag =' no discount' where discount =0 ;
update orders set  discount_flag =' low discount' where discount >0 and discount<=0.2;
update orders set  discount_flag =' high discount' where discount >0.2 ;
select discount, discount_flag from orders ;
#high discount wale orders ka profit kya h ?
select discount_flag , sum(profit) as total_profit from orders group by discount_flag;
#high sales but low profit categories
select category, sum(sales) as total_sales, sum(profit) as total_profit from orders group by category having total_sales >100000 and total_profit <5000;
# mini report query
select region, category , count(*) as total_orders, round(avg(discount),2) as avg_discount , sum(profit ) as total_profit from orders where sales >100 group by region, category having total_profit >0 order by total_profit desc;
#kitne unique categories h
select distinct category from orders;
#categories wise total sales
select category, sum(sales) as total_sales from orders group by category;
#loss making category
select category, sum(profit) as total_profit from orders group by category having total_profit;
# high discount (>=0.3) p loss ho raha ya ni
select category , sum(profit) as profit from orders where discount>=0.3 group by category having profit <0;
# add new coulumn 
alter table orders add profit_status varchar(20);
#update profit k hissab se status set kro
update orders set profit_status =case when profit >0 then 'profit' else 'loss' end;
#sirf loss wale orders matrk karo
update orders set profit_status ='loss' where profit<0;
#null records ya zero wale sare records hata do
delete from orders where sales=0;
select region , sum(sales) as total_sales from orders group by region having sum(sales)>5000;
