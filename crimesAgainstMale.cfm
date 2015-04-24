<cfsetting showdebugoutput="no">
<cfheader name="Content-Type" value="application/json">

<cfquery name="myQuery" datasource="crimeDataset">  
    select STATE_UT,SUM(TotalMale) AS SUM from d3js.crimedataset group by STATE_UT;
</cfquery>

<cfoutput>
#SerializeJSON(myQuery,true)#
</cfoutput>