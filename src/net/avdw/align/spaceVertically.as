package net.avdw.align
{
	import flash.text.TextField;
	
	/**
	 * Will space a collection of items underneath the first element with or without spacing gaps.
	 * Note that this method has been written to make the code neater and more compact visually.
	 * It can be written more efficiently by moving the spacing-type check out of the inner loop.
	 * @param	items				items to be vertically spaced
	 * @param	... spacingValues	the spacing to be used, either Number or Array
	 */
	public function spaceVertically(items:Array, ... spacingValues):void
	{
		if (!items)
			return;
		
		var i:int;
		for (i = 1; i < items.length; i++)
		{
			if (!items[i] || !items[i - 1] || !items[i - 1].hasOwnProperty("height") || !items[i].hasOwnProperty("y"))
				continue;
			
			if (spacingValues.length > 0)
			{ // determine type of spacing
				if (spacingValues[0] is Array)
				{ // space vertically using a spacing array
					items[i].y = int(items[(i - 1)].y + items[(i - 1)].height + spacingValues[0][i]);
				}
				else if (spacingValues[0] is Number)
				{ // space vertically using the same spacing value
					if (items[i - 1] is TextField)
					{ // space according to text height and not the textfield's height
						items[i].y = int(items[(i - 1)].y + items[(i - 1)].textHeight + spacingValues[0]);
					}
					else
					{ // space according to the objects height
						items[i].y = int(items[(i - 1)].y + items[(i - 1)].height + spacingValues[0]);
					}
				}
			}
			else
			{ // space vertically with no space
				items[i].y = int(items[(i - 1)].y + items[(i - 1)].height);
			}
		}
	}
}