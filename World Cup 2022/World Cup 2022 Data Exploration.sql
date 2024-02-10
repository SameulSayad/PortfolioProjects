-- THIS SCRIPT WILL BE USED TO EXPLORE A VARIETY OF QUESTIONS

-- 1. Which team scored the most goals?

SELECT team, SUM(goal_scored) as goals_scored
FROM fixtures
GROUP BY team
ORDER BY 2 DESC
LIMIT 1;

-- 2. Which team had the highest number of assists?

SELECT team, SUM(assists) as assists
FROM fixtures
GROUP BY team
ORDER BY 2 DESC
LIMIT 1;

	-- I NOTICED AN ERROR WITH ONE OF VALUES, "FRAM", THIS SHOULD READ AS FRANCE. THE DATASET IS ALSO UPDATED.
UPDATE fixtures
SET against = 'France'
WHERE against = 'Fram';
    
SELECT * FROM fixtures 
WHERE against = 'Fram';

-- 3. Which team conceded the most goals?

SELECT against,
	SUM(goal_scored) AS goals_conceded
FROM fixtures
GROUP BY against
ORDER BY 2 DESC;

-- 4.	Show a breakdown of the tournaments win-loss record.
	SELECT team,
		   COUNT(*) AS total_matches,
		   SUM(CASE WHEN points = 3 THEN 1 ELSE 0 END) AS total_wins,
		   SUM(CASE WHEN points = 1 THEN 1 ELSE 0 END) AS total_draws,
		   SUM(CASE WHEN points = 0 THEN 1 ELSE 0 END) AS total_losses
	FROM fixtures
	GROUP BY team
	ORDER BY total_wins DESC;

-- 5.	Which team had the most shots on target?

SELECT team, 
	SUM(shots_on_target) as shots_on_target
FROM fixtures
GROUP BY team
ORDER BY shots_on_target DESC;

-- 6. Calculate the goal conversion rate of each team.

SELECT team,
    SUM(goal_scored) AS goals_scored,
    SUM(shots_on_target) AS shots_on_target,
    ROUND((SUM(goal_scored) / NULLIF(SUM(shots_on_target), 0)) * 100, 2) AS conversion_rate
FROM fixtures
GROUP BY team
ORDER BY conversion_rate DESC;

-- 7.  Which team had the highest average possession and average passess completed throughout the tournament?

SELECT team,
	CONCAT(ROUND(AVG(possession),0),'%') AS highest_avg_possession,
   CONCAT(ROUND(SUM(passes_completed) / SUM(passes)*100,0),'%') AS avg_passes_completed
FROM fixtures
GROUP BY team
ORDER BY highest_avg_possession DESC;


-- 8. How many coaches are managing a country that is their nationality?

SELECT (
	-- This is the first subquery that calculates teams that have a national coach.
    SELECT COUNT(*)
	FROM coachdetails
	WHERE country = coach_nationality) AS team_with_national_coach,
    
-- This is the outermost part of the query calculation the count of total teams.
COUNT(*) AS total_teams,

-- This is the second subquery that calculates what percentage of managers make up the total number of national managers managing their own nation.
	CONCAT(ROUND((SELECT COUNT(*)
    FROM coachdetails
    WHERE country = coach_nationality) / COUNT(*) * 100, 2),'%') AS percentage_total
FROM coachdetails;

SELECT coach_name, country, coach_nationality,
COUNT(coach_nationality) OVER(PARTITION BY coach_nationality) AS coach_nationality
FROM Coachdetails
ORDER BY coach_nationality DESC


-- 9. Measuring the goal conversion rate for each team per game for the whole competition, and their overall goal accuracy. 

SELECT team, against, goal_scored, total_attempts,
CASE 
    WHEN total_attempts = 0 THEN '0' 
    ELSE CONCAT(ROUND(goal_scored/total_attempts,2),'%')
END AS goal_conversion,
	SUM(goal_scored) OVER(PARTITION BY team) AS comp_goals_scored,
    SUM(total_attempts) OVER(PARTITION BY team) AS comp_total_attempts,
    CONCAT(ROUND(SUM(goal_scored) OVER(PARTITION BY team) / SUM(total_attempts) OVER(PARTITION BY team),2),'%') AS competition_accuracy
FROM fixtures
ORDER BY competition_accuracy DESC;

-- 10. Find the total number of players registered per team and how many of them play in their national league. 

-- First I am checking how many players are playing in the same nation they are representing.
SELECT player_name, nation, country_league
FROM squaddetails
WHERE nation = country_league; 

-- This first view is the count of players that play in their national league. (Use N in join query).
CREATE VIEW national_league AS
SELECT nation, COUNT(*) as players 
FROM squaddetails
WHERE nation = country_league
GROUP BY nation
ORDER BY players DESC

-- This second view is the count of players registered for their national team. (Use R in join query).
CREATE VIEW registered_players AS
SELECT nation, COUNT(*) AS total_players
FROM squaddetails
GROUP BY nation
ORDER BY total_players DESC

-- Creating a left join using both the views to achieve desired results:
SELECT 
	n.nation, 
	n.players AS playing_in_their_nation,
	r.total_players AS total_players_registered,
    CONCAT(ROUND(n.players/total_players * 100,0),"%") AS percentage_players -- this percetage is showing how the percentage of players 
FROM national_league n
	JOIN registered_players r
    ON n.nation = r.nation
