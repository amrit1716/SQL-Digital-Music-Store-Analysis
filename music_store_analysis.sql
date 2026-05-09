#Question Set-1
#Q1. Who is the senior most employee based on the job title?
	select * from employee
    order by levels desc
    limit 1;
    
#Q2. Which countries have the most invoices?
	select billing_country, count(*) as Count
    from invoice
    group by billing_country
    order by Count desc;
    
#Q3. What are top 3 values of total invoice?
	select * from invoice 
    order by total desc
    limit 3;
    
#Q4. Which city has the best customer?
# We would like to throw a promotional Music Festival in the city we made the most money. 
# Write a query that returns one city that has highest sum of invoice totals. 
# Return both the city name & sum of all invoice totals. 
	select billing_city, sum(total) as InvoiceTotal
    from invoice 
    group by billing_city
    order by InvoiceTotal desc;
    
#Q5. Who is the best customer(the one who has spent the most)?
	select c.customer_id, concat(first_name, ' ', last_name) as CusName, 
		sum(total) as Amount
    from customer c
    join invoice i on i.customer_id=c.customer_id
    group by c.customer_id
    order by Amount desc
    limit 1;
    
#Question Set-2
#Q6. Write a query to return email, first name, last name & genre of all Rock Music listeners.
# Return you list ordered alphabetically by email starting with A.
	select distinct c.email, c.first_name, c.last_name, g.name as genre
    from customer c
    join invoice i on i.customer_id=c.customer_id
    join invoice_line il on il.invoice_id=i.invoice_id
    join track t on t.track_id=il.track_id
    join genre g on g.genre_id=t.genre_id
    where g.name='Rock'
    order by c.email;
    
#Q7. Let's invite the artist who have written the most rock music in our dataset.
# Write a query that returns the Artist Name and total track count of the top 10 rock bands.
	select ar.artist_id, ar.name, count(ar.artist_id) as TotalTrackCount
    from artist ar 
    join album al on al.artist_id=ar.artist_id
    join track t on t.album_id=al.album_id
    join genre g on g.genre_id=t.genre_id
    where g.name like 'Rock'
    group by ar.artist_id
    order by TotalTrackCount desc
    limit 10;
    
#Q8. Return all the track names that have a song length longer than the average song length.
# Return the Name & Millisecond for each track.
# Order by the song length with the longest songs listed first.
	select distinct name, milliseconds
    from track t1
    where milliseconds>(select avg(milliseconds) from track t2)
    order by milliseconds desc;

#Q9. How much amount spend by each customer on artist? Return customer, artist name & total spent.
	select c.customer_id, concat(c.first_name, ' ', last_name) as CusName,
		ar.name as ArtistName, sum(il.unit_price*il.quantity) as AmountSpent
    from customer c
    join invoice i on i.customer_id=c.customer_id
    join invoice_line il on il.invoice_id=i.invoice_id
    join track t on t.track_id=il.track_id
    join album al on al.album_id=t.album_id
    join artist ar on ar.artist_id=al.artist_id
    group by c.customer_id, c.first_name, c.last_name, ar.name
    order by amountspent desc;
    
#Question Set-3
#Q10. How much did each customer spend on the best-selling artist only? Return customer, artist name & total spent.
	with cte as(
		select ar.artist_id, ar.name,
			sum(il.unit_price*il.quantity) as TotalSales
		from artist ar 
		join album al on al.artist_id=ar.artist_id
		join track t on t.album_id=al.album_id
		join invoice_line il on il.track_id=t.track_id
		group by 1,2
		order by totalsales desc
		limit 1)
	select c.customer_id, concat(c.first_name, ' ', last_name) as CusName,
		cte.name as ArtistName, sum(il.unit_price*il.quantity) as AmountSpent
    from customer c
    join invoice i on i.customer_id=c.customer_id
    join invoice_line il on il.invoice_id=i.invoice_id
    join track t on t.track_id=il.track_id
    join album al on al.album_id=t.album_id
    join cte on cte.artist_id=al.artist_id
    group by 1, 2, 3
    order by AmountSpent desc;
    
#Q11. We want to find out the most popular music Genre for each country. 
# We determine the most popular genre as the genre with the highest amount of purchases. 
# Write a query that returns each country along with the top Genre. 
# For countries where the maximum number of purchases is shared return all Genres.
	with cte as
        (select c.country, g.name as genre, count(il.quantity) as Purchases,
			row_number() over(partition by c.country order by count(il.quantity) desc) as RowNo
		from customer c 
		join invoice i on i.customer_id=c.customer_id
		join invoice_line il on il.invoice_id=i.invoice_id
		join track t on t.track_id=il.track_id
		join genre g on g.genre_id=t.genre_id
		group by 1, 2
		order by 1, 3 desc)
	select * from cte 
    where RowNo=1;
    
#Q12. Write a query that determines the customer that has spent the most on music for each country. 
# Write a query that returns the country along with the top customer and how much they spent. 
# For countries where the top amount spent is shared, provide all customers who spent this amount.
	with cte as
		(select i.billing_country, c.first_name, c.last_name, sum(i.total) as TotalAmount,
			row_number() over(partition by i.billing_country order by sum(i.total) desc) as RowNo
		from invoice i
		join customer c on c.customer_id=i.customer_id
		group by 1, 2, 3
        order by 1, 4 desc)
	select * from cte
    where rowno=1;