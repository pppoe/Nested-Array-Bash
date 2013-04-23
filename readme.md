# What it is
Bash supports array but not nested-array, multi-dimensional array or any more advanced
conceptions. While I need the nested-array as a more structured input for my own project, I came up with this solution for a nested-array. This is NOT elegant but it  works.

# A sample
A nested-array will look like this:

```bash

    LIST=($(level_0 \    
            $(level_1 "Li" \
                $(level_2 \
                    $(level_3 "Age" "1") \
                    $(level_3 "Weight" "2") \
                    $(level_3 "Height"  "3") \
                    $(level_3 "Friends" \
                        $(level_4 "Sun" "Wang")) \
                    ))\
            $(level_1 "Wang" \
                $(level_2 \
                    $(level_3 "Age" "11") \
                    $(level_3 "Weight" "12") \
                    $(level_3 "Height" "13") \
                    $(level_3 "Friends" \
                        $(level_4 "Li" "Sun")) \
                    ))\
            $(level_1 "Sun" \
                $(level_2 \
                    $(level_3 "Age" "21") \
                    $(level_3 "Weight" "22") \
                    $(level_3 "Height" "23") \
                    $(level_3 "Friends" \
                        $(level_4 "Li" "Wang")) \
                    ))\
                ))
```
            
With some work you can populate the elements, and output them into a markdown nested list:

-----

# name: Li
* Age:
	* 1
* Weight:
	* 2
* Height:
	* 3
* Friends:
	* Sun
	* Wang

# name: Wang
* Age:
	* 11
* Weight:
	* 12
* Height:
	* 13
* Friends:
	* Li
	* Sun

# name: Sun
* Age:
	* 21
* Weight:
	* 22
* Height:
	* 23
* Friends:
	* Li
	* Wang
	
-----

# How it works
The motivation is that when bash populate an array, it will refer to the environmental variable ``IFS`` as the separator of fields. So in order to have nested array, a straight forward idea is to use different ``IFS`` for different nested levels.

For example, 

    Li,Age*1;Weight*2;Height*3;Friends*Sun^Wang Wang,Age*11;Weight*12;Height*13;Friends*Li^Sun
    
The one above can represent a nested array where ``space`` is separator of the the top level.
One element in the first level is like this:

    Li,Age*1;Weight*2;Height*3;Friends*Sun^Wang

Similarly, ``,`` separate it into ``Li`` and ``Age*1;Weight*2;Height*3;Friends*Sun^Wang``. 
After that ``;`` separate the latter into a group of elements: 
``Age*1``, ``Weight*2``, ``Height*3`` and ``Friends*Sun^Wang``. 

This is the whole point in my solution. 
To generate the complicated nested-array representation, 
I am using the script (nested-array.sh) to generate a serial of functions each one will replace the default ``IFS`` (space) with certain symbol which will NOT be used in the content.
