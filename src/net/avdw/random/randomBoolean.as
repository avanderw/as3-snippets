package net.avdw.random 
{
		
		/**
		 * randBoolean(); // returns true or false (50% chance of true)
		 * randBoolean(0.8); // returns true or false (80% chance of true)
		 * @param	chance
		 * @return
		 */
		public function randomBoolean(chance:Number = 0.5):Boolean 
		{
			return Math.random() < chance;
		}

}