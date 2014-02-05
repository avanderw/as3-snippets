package net.avdw.card
{
	public function potOdds(bet:int, pot:int):Number
	{
		return bet / (bet + pot);
	}
}