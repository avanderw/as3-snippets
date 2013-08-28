package net.avdw.array
{
	public function print2x2Matrix(matrix:Array):void
	{
		var print:String = "";
		for (var i:int = 0; i < matrix.length; i++)
		{
			for (var j:int = 0; j < matrix[i].length; j++)
			{
				print += matrix[i][j] + ",\t";
			}
			print = print.substring(0, print.length - 2);
			print += "\n";
		}
		print = print.substring(0, print.length - 1);
		
		trace(print);
	}
}