--Set 3 Advance level questions
/* Q1: Find how much amount spent by each customer on artists?
Write a query to return customer name,artist name and total spent */


WITH best_selling_artist AS(
SELECT artist.artist_id AS artist_id, artist.name AS artist_name,
SUM(invoice_line.unit_price * invoice_line.quantity)AS total_sales
FROM invoice_line
JOIN track ON track.track_id = invoice_line.track_id
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
GROUP BY 1 -- 1 is artist id
ORDER BY 3 DESC -- 3 is order 
LIMIT 1
)
SELECT c.customer_id, c.first_name,c.last_name, bsa.artist_name,
SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c on c.customer_id = i.customer_id
JOIN invoice_line il on il.invoice_id = i.invoice_id
JOIN track t on t.track_id=il.track_id
JOIN album alb on alb.album_id = t.album_id
JOIN best_selling_artist bsa on bsa.artist_id = alb.artist_id
GROUp BY 1,2,3,4
ORDER BY 5 DESC	

--question2

WITH popular_genre AS
(
SELECT COUNT(quantity) AS purchases, customer.country,genre.name, genre.genre_id,
ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC)AS RowNo
FROM invoice_line
JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
JOIN customer ON customer.customer_id = invoice.customer_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
GROUP BY 2,3,4
ORDER BY 2 ASC, 1 DESC 
)
SELECT * FROM popular_genre WHERE RowNo<=1