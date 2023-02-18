-- Retrieve all films with a rating of G or PG, which are are not currently rented (they have been returned/have never been borrowed).
SELECT *
FROM movies
    LEFT JOIN rentals ON movies.movie_id = rentals.movie_id
WHERE (
        rating = 'G'
        OR rating = 'PG'
    )
    AND (
        rentals.rental_id IS NULL
        OR rentals.return_date IS NOT NULL
    ) --Create a new table which will represent a waiting list for children’s movies. This will allow a child to add their name to the list until the DVD is available (has been returned). Once the child takes the DVD, their name should be removed from the waiting list (ideally using triggers, but we have not learned about them yet. Let’s assume that our Python program will manage this). Which table references should be included?
    CREATE TABLE waiting_list (
        waiting_id SERIAL PRIMARY KEY,
        movie_id INTEGER REFERENCES movies(movie_id),
        child_name VARCHAR(255),
        date_added DATE
    );
-- Retrieve the number of people waiting for each children’s DVD. Test this by adding rows to the table that you created in question 2 above.
SELECT movies.title,
    COUNT(waiting_list.waiting_id) AS num_waiting
FROM movies
    LEFT JOIN waiting_list ON movies.movie_id = waiting_list.movie_id
GROUP BY movies.title