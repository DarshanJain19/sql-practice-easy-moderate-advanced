-- Question Set 2 Moderate

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */
select * from genre
select * customer
select* from track
--method 1
select email, first_name, last_name
from customer as c
join invoice as i 
on c.customer_id = i. customer_id
join invoice_line as il 
on i.invoice_id = il.invoice_id
where track_id in(
select track_id from track
join genre as g
on track.genre_id=g.genre_id
where g.name = 'Rock'
)
order by email

--method 2
SELECT distinct email,first_name,last_name,genre
from customer
join invoice on invoice.customer_id = customer.customer_id
join invoice_line on  invoice_line.invoice_id= invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id=track.genre_id  
where genre.name = 'Rock'
order by email

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */


select * from track
select * from genre
select * from track

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs 
from track 
join album 
on album.album_id= track.album_id
join artist 
on artist.artist_id=album.artist_id
join genre 
on genre.genre_id = track.genre_id
where genre.name='Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select * from track
select name, milliseconds
from track
where milliseconds>(
select avg(milliseconds) as avg_length 
from track )
order by milliseconds desc