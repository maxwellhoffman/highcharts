<cfsetting showdebugoutput="no">
<cfheader name="Content-Type" value="application/json">

<cfquery name="myQuery" datasource="crimeDataset">  
    select Year,SUM(Total) AS SUM from d3js.crimedataset group by Year;
</cfquery>

<cfoutput>
#SerializeJSON(myQuery,true)#
</cfoutput>