# LIMS Nutrient File Conversions
converting between a FDEP LIMS Browser export file into user-friendly formats and those used for NERRS nutrient QAQC

## Step One: LIMS Browser Template Export
*these are the steps for those with LIMS Browser access and using GTM-NERR as example*

1. Login to LIMS
2. General – LIMS Browser
3. Search by Project ID. *In database: If prior to current year -> Legacy*
4. Build List -> GTM-NERR -> OK

![Figure 1](/images/figure1.jpg)

5. Report Files – Select Interested “Event” or “Events” – Select all jobs

![](/images/figure2.jpg)

6. Open template - "GTM_LIMS_V2" - OK *this is what I have named my template*

### Need to create your own?
*Add the fields listed below from Available Fields box into the Selected Fields/Column Order box by highlighting the field of interest and clicking the plain text arrow -> to the right of the box. Using the bold arrow -> will add all available fields into the selected fields column. The selected fields need to be in the exact order listed below. The column order of the selected fields can be rearranged using the up and down arrows below the Selected Fields/Column Order box. Once the column order mirrors the listed column order below, clicking the bold arrow -> to the right of Selected Fields/Column Order box will add the selected fields into the Sort By box in the correct order. Template can be saved using the Save Template icon in the top of the browser window.*
- GTM_LIMS_v2 Template Order:
- Request ID
- Site Location
- Storet Station
- Latitude
- Longitude
- Field ID
- Date sampled
- Date analyzed
- Group ID
- Analysis
- Component
- Storet Parameter
- Result
- Remark
- MDL
- PQL
-	Units
-	Test comments
-	Matrix
-	Temperature
-	Specific Conductance
-	Salinity
-	pH
-	Dissolved O2
-	Sample Depth
-	Batch ID
-	Sample ID
-	Preservation
-	Reference method

7. Edit report title
8. View / Print Report
9. Preview - Save -> Excel Table XML
  a. Page range - All
  b. Export Settings
    - Continuous - Yes
    - Page Break - No
    - WYSIWYG - No
    - Background - No
    - Split to Sheet - Don't Split
10. Open in Excel after export - OK
11. Add file name
  a. Error message - corrupted on unsafe - YES
12. Format cells - Fill - No color
13. Delete top 2 rows
14. Create table
15. Delete extra columns
16. Open "Nutrient File Conversions" project folder
17. Open the "/data" subfolder.
18. Paste your exported LIMS file into this folder ***Be sure to rename the file to "LIMS.xlsx"***

## Code Explanations
