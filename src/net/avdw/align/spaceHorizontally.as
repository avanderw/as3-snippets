package net.avdw.align
{
	import flash.text.TextField;
	import utils.object.inspect;
	import utils.object.toString;
	
	/**
	 * Will space a collection of items underneath the first element with or without spacing gaps.
	 * Note that this method has been written to make the code neater and more compact visually.
	 * It can be written more efficiently by moving the spacing-type check out of the inner loop.
	 * @param	items				items to be horizontally spaced
	 * @param	... spacingValues	the spacing to be used, either Number or Array
	 */
	public function spaceHorizontally(items:Array, ... spacingValues):void
	{
		if (!items)
			return;
		
		var i:int;
		for (i = 1; i < items.length; i++)
		{
			if (!items[i] || !items[i - 1] || !items[i - 1].hasOwnProperty("width") || !items[i].hasOwnProperty("x"))
				continue;
				
			if (spacingValues.length > 0 && spacingValues[0] != null)
			{ // determine type of spacing
				if (spacingValues[0] is Array)
				{ // space horizontally using a spacing array
					items[i].x = int(items[(i - 1)].x + items[(i - 1)].width + spacingValues[0][i]);
				}
				else if (spacingValues[0] is Number)
				{ // space horizontally using the same spacing value
					if (items[i - 1] is TextField)
					{ // space according to text width and not the textfield's width
						items[i].x = int(items[(i - 1)].x + items[(i - 1)].textWidth + spacingValues[0]);
					}
					else
					{ // space according to the objects width
						items[i].x = int(items[(i - 1)].x + items[(i - 1)].width + spacingValues[0]);
					}
				}
			}
			else
			{ // space horizontally with no space
				items[i].x = int(items[(i - 1)].x + items[(i - 1)].width);
				trace(items[i].x);
			}
		}
	}
}