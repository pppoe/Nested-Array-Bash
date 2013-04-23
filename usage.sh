#! /bin/bash

# Include the nested-array mechanic (up to level_4)
source nested-array.sh

## A sample list 
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

DEF_IFS=$IFS

### Showing how to traverse through the list
echo ${LIST[@]}

echo "##########################"
echo "Traverse to Level 1"
echo "##########################"

# Set the IFS for level 0
IFS=${l_ifs[0]}    
for person in ${LIST[@]}; do
    # Set the IFS for level 1 
    # Populate the element with respect to current IFS
    IFS=${l_ifs[1]}; loc_person=($person) 

    name=${loc_person[0]}
    items=${loc_person[1]} # An array as an element

    echo "name: ${name}"
    echo "items: ${items}"
done

echo "##########################"
echo "Traverse to Level 2"
echo "##########################"
# Set the IFS for level 0
IFS=${l_ifs[0]}    
for person in ${LIST[@]}; do
    # Set the IFS for level 1 
    # Populate the element with respect to current IFS
    IFS=${l_ifs[1]}; loc_person=($person) 

    name=${loc_person[0]}
    items=${loc_person[1]} # An array as an element

    echo "name: ${name}"

    # Set the IFS for level 2
    # Populate the element with respect to current IFS
    IFS=${l_ifs[2]}; loc_items=($items)  
    echo "items:"
    for item in ${loc_items[@]}; do
        echo -e "\t${item}"
    done
done

echo "##########################"
echo "Traverse to Level 3"
echo "##########################"
# Set the IFS for level 0
IFS=${l_ifs[0]}    
for person in ${LIST[@]}; do
    # Set the IFS for level 1 
    # Populate the element with respect to current IFS
    IFS=${l_ifs[1]}; loc_person=($person) 

    name=${loc_person[0]}
    items=${loc_person[1]} # An array as an element

    echo "name: ${name}"

    # Set the IFS for level 2
    # Populate the element with respect to current IFS
    IFS=${l_ifs[2]}; loc_items=($items)  
    echo "items:"
    for item in ${loc_items[@]}; do

        # Set the IFS for level 3
        # Populate the element with respect to current IFS
        IFS=${l_ifs[3]}; loc_item=($item) 

        item_name=${loc_item[0]}
        item_value=${loc_item[1]}

        echo -e "\t${item_name}: ${item_value}"
    done
done

echo "##########################"
echo "Traverse to Level 4"
echo "##########################"
# Set the IFS for level 0
IFS=${l_ifs[0]}    
for person in ${LIST[@]}; do

    # Set the IFS for level 1 
    # Populate the element with respect to current IFS
    IFS=${l_ifs[1]}; loc_person=($person) 

    name=${loc_person[0]}
    items=${loc_person[1]} # An array as an element

    echo "name: ${name}"

    # Set the IFS for level 2
    # Populate the element with respect to current IFS
    IFS=${l_ifs[2]}; loc_items=($items)  
    echo "items:"
    for item in ${loc_items[@]}; do

        # Set the IFS for level 3
        # Populate the element with respect to current IFS
        IFS=${l_ifs[3]}; loc_item=($item) 

        item_name=${loc_item[0]}
        item_value=${loc_item[1]}

        echo -e "\t${item_name}:"

        # Set the IFS for level 4
        # Populate the element with respect to current IFS
        IFS=${l_ifs[4]}; loc_details=($item_value) 

        for detail in ${loc_details[@]}; do
            echo -e "\t\t${detail}"
        done
    done
done

echo "##########################"
echo "Traverse to Markdown list"
echo "##########################"
# Set the IFS for level 0
IFS=${l_ifs[0]}    
for person in ${LIST[@]}; do

    # Set the IFS for level 1 
    # Populate the element with respect to current IFS
    IFS=${l_ifs[1]}; loc_person=($person) 

    name=${loc_person[0]}
    items=${loc_person[1]} # An array as an element

    echo -e "\n# name: ${name}"

    # Set the IFS for level 2
    # Populate the element with respect to current IFS
    IFS=${l_ifs[2]}; loc_items=($items)  
    for item in ${loc_items[@]}; do

        # Set the IFS for level 3
        # Populate the element with respect to current IFS
        IFS=${l_ifs[3]}; loc_item=($item) 

        item_name=${loc_item[0]}
        item_value=${loc_item[1]}

        echo -e "* ${item_name}:"

        # Set the IFS for level 4
        # Populate the element with respect to current IFS
        IFS=${l_ifs[4]}; loc_details=($item_value) 

        for detail in ${loc_details[@]}; do
            echo -e "\t* ${detail}"
        done
    done
done
############################################

IFS=$DEF_IFS
