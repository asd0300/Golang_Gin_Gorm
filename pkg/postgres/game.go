package postgres

type Game struct {
	ID       int
	WinnerID int
	Location string
	Prize    int
}

type JoinResult struct {
	Player
	Game
}
