var regionloaded = false;
var provinceloaded = false;
var cityloaded = false;
var modal = document.getElementById("myModal");
var span = document.getElementsByClassName("close")[0];
var warningTimeout = 840000;
var timoutNow = 60000;
var warningTimerID, timeoutTimerID;

$(document).ready(function () {
    
    $('.menu-link').click(function (e) {
//            e.preventDefault(); // Prevent default link behavior
            var page = $(this).data('page');
            $('#main-content').load('views/' + page + '.jsp');
    });
   
    $("#DIVSFCTABS").tabs();
        $("#accordion").accordion();
        $('#updateaccinfo').hide();
        $('#updatesecinfo').hide();
        $('#updatepart2inv').hide();
        $('#updatepart3').hide();
        $('#updatepart4').hide();
        $('#updatepart5').hide();
        $('#group11_1_others').hide();
        $('#typeinvothers').hide();
        document.getElementById('COLSDGNA').style.display = "none";
        document.getElementById('COLGPNA').style.display = "none";
        document.getElementById("I").style.display = "block";        
        document.getElementById("I").selected = "true";        
        $("[name='accountname']").prop("disabled", true);
        document.getElementById("ecc1").checked=true;
        var regionloaded = false; var provinceloaded = false; var cityloaded = false; var brgyloaded = false; var regionloadedproj = false; var provinceloadedproj = false;
        var cityloadedproj = false; var brgyloadedproj = false; var programloaded = false; var lguprojectloaded = false; var CADT_CALT_REGIONloaded = false; var CADT_CALT_NOloaded = false;
        var radiocnc=document.getElementsByName("cnc");
        var len=radiocnc.length;
        for(var i=0;i<len;i++)
            {
                radiocnc[i].disabled=true;
            }

            $("#accordionmaintenance").on('click', function () {
            clearalldiv();
            hideadmin();
        });

        $("#accordiontools").on('click', function () {
            clearalldiv();
            hideadmin();
        });

        $("#accordionreports").on('click', function () {
            clearalldiv();
            hideadmin();
        });

        $("#accordionusermain").on('click', function () {
            clearalldiv();
            hideadmin();
        });
        
        
          $("#region").click(function () {
            $.ajax({
                url: "DDRegionDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (regionloaded)
                        return;
                    $("#region").empty();
                    $("#region").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#region").append("<option>" + list[i].region + "</option>");
                    }
                    regionloaded = true;
                }
            });
        });
        


        $("#region").change(function () {
            var regiondesc = $("#region").val();
            $("#province").empty();
            $("#provincecode").val("");
            $("#city").empty();
            $("#citycode").val("");
            $("#brgy").empty();
            $("#brgycode").val("");
            provinceloaded = false;
            cityloaded = false;
            brgyloaded = false;
            $.ajax({
                url: "DDRegionCodeServlet",
                dataType: 'json',
                data: {x: regiondesc},
                success: function (json) {
                    $('#regioncode').val(json.regcode);
                }
            });
        });

        $("#province").click(function () {
            var regionid = $("#regioncode").val();
            $.ajax({
                url: "DDProvinceDataServlet",
                dataType: 'json',
                data: {x: regionid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (provinceloaded)
                        return;
                    $("#province").empty();
                    $("#province").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#province").append("<option>" + list[i].provinceName + "</option>");
                    }
                    provinceloaded = true;
                }
            });
        });

        $("#province").change(function () {
            var provincedesc = $("#province").val();
            $("#city").empty();
            $("#citycode").val("");
            $("#brgy").empty();
            $("#brgycode").val("");
            cityloaded = false;
            brgyloaded = false;
            $.ajax({
                url: "DDProvinceCodeServlet",
                dataType: 'json',
                data: {x: provincedesc},
                success: function (json) {
                    $('#provincecode').val(json.provcode);
                }
            });
        });

        $("#city").click(function () {
            var regionid = $("#regioncode").val();
            var provinceid = $("#provincecode").val();
            $.ajax({
                url: "DDCityDataServlet",
                dataType: 'json',
                data: {x: regionid, y: provinceid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (cityloaded)
                        return;
                    $("#city").empty();
                    $("#city").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#city").append("<option>" + list[i].city + "</option>");
                    }
                    cityloaded = true;
                }
            });
        });

        $("#city").change(function () {
            var citydesc = $("#city").val();
            var regionid = $("#regioncode").val();
            var provinceid = $("#provincecode").val();
            $("#brgy").empty();
            $("#brgycode").val("");
            brgyloaded = false;
            $.ajax({
                url: "DDCityCodeServlet", dataType: 'json',
                data: {x: citydesc, y: regionid, z: provinceid},
                success: function (json) {
                    $('#citycode').val(json.citycode);
                }
            });
        });

        $("#brgy").click(function () {
            var regionid = $("#regioncode").val();
            var provinceid = $("#provincecode").val();
            var cityid = $("#citycode").val();
            $.ajax({
                url: "DDBrgyDataServlet",
                dataType: 'json',
                data: {x: regionid, y: provinceid, z: cityid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (brgyloaded)
                        return;
                    $("#brgy").empty();
                    $("#brgy").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#brgy").append("<option>" + list[i].brgy + "</option>");
                    }
                    brgyloaded = true;
                }
            });
        });

        $("#brgy").change(function () {
            var brgydesc = $("#brgy").val();
            var regionid = $("#regioncode").val();
            var provinceid = $("#provincecode").val();
            var cityid = $("#citycode").val();
            $.ajax({
                url: "DDBrgyCodeServlet",
                dataType: 'json',
                data: {x: brgydesc, y: regionid, z: provinceid, w: cityid},
                success: function (json) {
                    $('#brgycode').val(json.barangaycode);
                }
            });
        });

        $("#regionproj").click(function () {
            $.ajax({
                url: "DDRegionDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (regionloadedproj)
                        return;
                    $("#regionproj").empty();
                    $("#regionproj").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#regionproj").append("<option>" + list[i].region + "</option>");
                    }
                    regionloadedproj = true;
                }
            });
        });

        $("#regionproj").change(function () {
            var regiondesc = $("#regionproj").val();
            $("#provinceproj").empty();
            $("#provincecodeproj").val("");
            $("#cityproj").empty();
            $("#citycodeproj").val("");
            $("#brgyproj").empty();
            $("#brgycodeproj").val("");
            provinceloadedproj = false;
            cityloadedproj = false;
            brgyloadedproj = false;
            $.ajax({
                url: "DDRegionCodeServlet",
                dataType: 'json',
                data: {x: regiondesc},
                success: function (json) {
                    $('#regioncodeproj').val(json.regcode);
                }
            });
        });

        $("#provinceproj").click(function () {
            var regionid = $("#regioncodeproj").val();
            $.ajax({
                url: "DDProvinceDataServlet",
                dataType: 'json',
                data: {x: regionid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (provinceloadedproj)
                        return;
                    $("#provinceproj").empty();
                    $("#provinceproj").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#provinceproj").append("<option>" + list[i].provinceName + "</option>");
                    }
                    provinceloadedproj = true;
                }
            });
        });

        $("#provinceproj").change(function () {
            var provincedesc = $("#provinceproj").val();
            $("#cityproj").empty();
            $("#citycodeproj").val("");
            $("#brgyproj").empty();
            $("#brgycodeproj").val("");
            cityloadedproj = false;
            brgyloadedproj = false;
            $.ajax({
                url: "DDProvinceCodeServlet",
                dataType: 'json',
                data: {x: provincedesc},
                success: function (json) {
                    $('#provincecodeproj').val(json.provcode);
                }
            });
        });

        $("#cityproj").click(function () {
            var regionid = $("#regioncodeproj").val();
            var provinceid = $("#provincecodeproj").val();
            $.ajax({
                url: "DDCityDataServlet",
                dataType: 'json',
                data: {x: regionid, y: provinceid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (cityloadedproj)
                        return;
                    $("#cityproj").empty();
                    $("#cityproj").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#cityproj").append("<option>" + list[i].city + "</option>");
                    }
                    cityloadedproj = true;
                }
            });
        });

        $("#cityproj").change(function () {
            var citydesc = $("#cityproj").val();
            var regionid = $("#regioncodeproj").val();
            var provinceid = $("#provincecodeproj").val();
            $("#brgyproj").empty();
            $("#brgycodeproj").val("");
            brgyloadedproj = false;
            $.ajax({
                url: "DDCityCodeServlet", dataType: 'json',
                data: {x: citydesc, y: regionid, z: provinceid},
                success: function (json) {
                    $('#citycodeproj').val(json.citycode);
                }
            });
        });

        $("#brgyproj").click(function () {
            var regionid = $("#regioncodeproj").val();
            var provinceid = $("#provincecodeproj").val();
            var cityid = $("#citycodeproj").val();
            $.ajax({
                url: "DDBrgyDataServlet",
                dataType: 'json',
                data: {x: regionid, y: provinceid, z: cityid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (brgyloadedproj)
                        return;
                    $("#brgyproj").empty();
                    $("#brgyproj").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#brgyproj").append("<option>" + list[i].brgy + "</option>");
                    }
                    brgyloadedproj = true;
                }
            });
        });

        $("#brgyproj").change(function () {
            var brgydesc = $("#brgyproj").val();
            var regionid = $("#regioncodeproj").val();
            var provinceid = $("#provincecodeproj").val();
            var cityid = $("#citycodeproj").val();
            $.ajax({
                url: "DDBrgyCodeServlet",
                dataType: 'json',
                data: {x: brgydesc, y: regionid, z: provinceid, w: cityid},
                success: function (json) {
                    $('#brgycodeproj').val(json.barangaycode);
                }
            });
        });

        $('input[type=radio][name=lendinv]').change(function () {
            if (this.value === 'Investment') {
                document.getElementById('lblinvestmentloanid').innerHTML = 'Investment ID*';
                document.getElementById('I').innerHTML = 'I. Security Information';
                document.getElementById("part1_lend").style.display = "none";
                document.getElementById("part1_inv").style.display = "block";
                $('h4.manager').text('Create Sustainability Finance Checklist - Investment');
                document.getElementById("part2_inv").style.display = "block";
                document.getElementById("part2_lend").style.display = "none";                
                document.getElementById("tabs-4").style.visibility = "hidden";                
                document.getElementById("part4").style.display = "none";   
                document.getElementById('COLSDGNA').style.display = "block";
                document.getElementById('COLGPNA').style.display = "block";                
                document.getElementById('IV').style.visibility = "hidden";
                document.getElementById('IV').style.display = "none"
                document.getElementById('V').innerHTML = 'IV. Social Aspects <br> and Impact';
                document.getElementById('VI').innerHTML = 'V. Project/Project Site <br>Exposure to Natural/<br>Climate Change Hazards';
                
                clearGPcheckbox();
                clearSDGcheckbox();
                clearpart2main();
                clearresultindicators();
                clearallgroupdiv();                
            } else if (this.value === 'Lending') {                
                document.getElementById('lblinvestmentloanid').innerHTML = 'Loan ID*';
                document.getElementById('I').innerHTML = 'I. Account Information';
                document.getElementById("part1_inv").style.display = "none";
                document.getElementById("tabs-4").style.visibility = "visible";
                document.getElementById("part1_lend").style.display = "block";                
                document.getElementById("part4").style.display = "block";                
                $('h4.manager').text('Create Sustainability Finance Checklist - Lending');
                document.getElementById('V').innerHTML = 'V. Social Aspects <br> and Impact';         
                document.getElementById('IV').style.visibility = "visible";
                document.getElementById("part2_inv").style.display = "none";
                document.getElementById("part2_lend").style.display = "block";
                document.getElementById('COLSDGNA').style.display = "none";
                document.getElementById('COLGPNA').style.display = "none";
                document.getElementById('IV').style.visibility = "visible";
                document.getElementById('IV').style.display = "block"        
                document.getElementById('VI').innerHTML = 'VI. Project/Project Site <br>Exposure to Natural/<br>Climate Change Hazards';
                clearGPcheckbox();
                clearSDGcheckbox();
                clearresultindicators();
                clearpart2main();
                clearallgroupdiv();
            }
        });
    
        $('input[type=radio][name=environmentalimpact]').change(function () {
            if (this.value === 'Yes') {                
                var radiocheckcnc=document.getElementsByName("cnc");
                var lencnc=radiocheckcnc.length;
                for(var i=0;i<lencnc;i++)
                    {
                        radiocheckcnc[i].disabled=true;
                    }                
                var radiocheckecc=document.getElementsByName("ecc");                
                var lenecc=radiocheckecc.length;                
                for(var i=0;i<lenecc;i++)
                    {
                        radiocheckecc[i].disabled=false;
                    }                
                document.querySelector('input[name="cnc"]:checked').checked = false;                                    
                document.getElementById("ecc1").checked=true;
            } else if (this.value === 'No') {                
                var radiocheckcnc=document.getElementsByName("cnc");                
                var lencnc=radiocheckcnc.length;
                for(var i=0;i<lencnc;i++)
                    {
                        radiocheckcnc[i].disabled=false;
                    }                
                var radiocheckecc=document.getElementsByName("ecc");
                var lenecc=radiocheckecc.length;
                for(var i=0;i<lenecc;i++)
                    {
                        radiocheckecc[i].disabled=true;
                    }                
                document.querySelector('input[name="ecc"]:checked').checked = false;  
                document.getElementById("cnc1").checked=true; 
            }
        });


        $('input[type=radio][name=availlendprog]').change(function () {
            programloaded = false;
            $("#program").empty();
            $("#program").append("<option value=blank>Select Value</option>");
            $('#programgroupcode').val('');
            $('#lendingprogramcode').val('');
            clearGPcheckbox();
            clearSDGcheckbox();
            clearresultindicators();
            clearallgroupdiv();
        });

        $('input[type=radio][name=indvcorp]').change(function () {
            if (this.value === 'Individual') {
                $("[name='accountname']").prop("disabled", true);
                document.getElementById("lblfirstname").style.display = "block";
                document.getElementById("lblfirstname").style.visibility = "visible";
                document.getElementById("firstname").style.display = "block";
                document.getElementById("firstname").style.visibility = "visible";
                document.getElementById("lblmiddlename").style.display = "block";
                document.getElementById("lblmiddlename").style.visibility = "visible";
                document.getElementById("middlename").style.display = "block";
                document.getElementById("middlename").style.visibility = "visible";
                document.getElementById("lblsuffix").style.display = "block";
                document.getElementById("lblsuffix").style.visibility = "visible";
                document.getElementById("suffix").style.display = "block";
                document.getElementById("suffix").style.visibility = "visible";
                document.getElementById("lbllastname").style.display = "block";
                document.getElementById("lbllastname").style.visibility = "visible";
                document.getElementById("lastname").style.display = "block";
                document.getElementById("lasttname").style.visibility = "visible";
            } else if (this.value === 'Corporate') {
                $("[name='accountname']").prop("disabled", false);
                document.getElementById("lblfirstname").style.display = "none";
                document.getElementById("lblfirstname").style.visibility = "hidden";
                document.getElementById("firstname").style.display = "none";
                document.getElementById("firstname").style.visibility = "hidden";
                document.getElementById("lblmiddlename").style.display = "none";
                document.getElementById("lblmiddlename").style.visibility = "hidden";
                document.getElementById("middlename").style.display = "none";
                document.getElementById("middlename").style.visibility = "hidden";
                document.getElementById("lblsuffix").style.display = "none";
                document.getElementById("lblsuffix").style.visibility = "hidden";
                document.getElementById("suffix").style.display = "none";
                document.getElementById("suffix").style.visibility = "hidden";
                document.getElementById("lbllastname").style.display = "none";
                document.getElementById("lbllastname").style.visibility = "hidden";
                document.getElementById("lastname").style.display = "none";
                document.getElementById("lasttname").style.visibility = "hidden";
            }
        });

        $("#savesecinfo").on('click', function () {
            var lendinv = document.querySelector('input[name="lendinv"]:checked').value; var esrequestid = $("#esrequestid").val(); var investmentloanid = $("#investmentloanid").val();
            var securityname = $("#securityname").val(); var issuer = $("#issuer").val(); var useofproceeds = $("#useofproceeds").val(); var accountname = ""; var indvcorp = ""; 
            var firstname = ""; var middlename = ""; var lastname = ""; var suffix = ""; var financedproject = ""; var room = ""; var lot = ""; var buildingname = ""; var street = "";
            var subdivision = ""; var region = ""; var province = ""; var city = ""; var district = ""; var brgy = ""; var postalcode = ""; var roomproj = ""; var lotproj = "";
            var buildingnameproj = ""; var streetproj = ""; var subdivisionproj = ""; var regionproj = ""; var provinceproj = ""; var cityproj = ""; var districtproj = ""; var brgyproj = ""; var postalcodeproj = "";
            if (investmentloanid === "") {
                alert("Investment ID is required!");
                event.preventDefault();
                return false;
            }
            if (securityname === "") {
                alert("Security Name is required!");
                event.preventDefault();
                return false;
            }
            if (issuer === "") {
                alert("Issuer is required!");
                event.preventDefault();
                return false;
            }
            if (useofproceeds === "") {
                alert("Use of Proceeds is required!");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "Part1SecAddServlet",
                dataType: 'json',
                data: {lendinv: lendinv, investmentloanid: investmentloanid, securityname: securityname,
                    issuer: issuer, useofproceeds: useofproceeds, accountname: accountname, indvcorp: indvcorp,
                    firstname: firstname, middlename: middlename, lastname: lastname, suffix: suffix,
                    financedproject: financedproject, room: room, lot: lot, buildingname: buildingname,
                    street: street, subdivision: subdivision, region: region, province: province, city: city,
                    district: district, brgy: brgy, postalcode: postalcode, roomproj: roomproj, lotproj: lotproj,
                    buildingnameproj: buildingnameproj, streetproj: streetproj, subdivisionproj: subdivisionproj,
                    regionproj: regionproj, provinceproj: provinceproj, cityproj: cityproj, districtproj: districtproj,
                    brgyproj: brgyproj, postalcodeproj: postalcodeproj},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        //alert((json.res));                        
                        //filltable();
                        //cleardepdiv();                       
                        $("#esrequestid").val((json.res).substring((json.res).length, 5));
                        hidebuttonsectab1();
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });
        $("#saveaccinfo").on('click', function () {
            var lendinv = document.querySelector('input[name="lendinv"]:checked').value; var esrequestid = $("#esrequestid").val();
            var investmentloanid = $("#investmentloanid").val(); var securityname = ""; var issuer = "";
            var useofproceeds = ""; var accountname = $("#accountname").val(); var indvcorp = document.querySelector('input[name="indvcorp"]:checked').value;
            var firstname = $("#firstname").val(); var middlename = $("#middlename").val(); var lastname = $("#lastname").val();
            var suffix = $("#suffix").val(); var financedproject = $("#financedproject").val(); var room = $("#room").val(); var lot = $("#lot").val();
            var buildingname = $("#buildingname").val(); var street = $("#street").val(); var subdivision = $("#subdivision").val(); var region = $("#region").val();
            var province = $("#province").val(); var city = $("#city").val(); var district = $("#district").val(); var brgy = $("#brgy").val();
            var postalcode = $("#postalcode").val(); var roomproj = $("#roomproj").val(); var lotproj = $("#lotproj").val(); var buildingnameproj = $("#buildingnameproj").val();
            var streetproj = $("#streetproj").val(); var subdivisionproj = $("#subdivisionproj").val(); var regionproj = $("#regionproj").val(); var provinceproj = $("#provinceproj").val();
            var cityproj = $("#cityproj").val();var districtproj = $("#districtproj").val(); var brgyproj = $("#brgyproj").val(); var postalcodeproj = $("#postalcodeproj").val();

            if (investmentloanid === "") {
                alert("Loan ID is required!");
                event.preventDefault();
                return false;
            }
            if (financedproject === "") {
                alert("Financed Project is required!");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "Part1SecAddServlet",
                dataType: 'json',
                data: {lendinv: lendinv, investmentloanid: investmentloanid, securityname: securityname,
                    issuer: issuer, useofproceeds: useofproceeds, accountname: accountname, indvcorp: indvcorp,
                    firstname: firstname, middlename: middlename, lastname: lastname, suffix: suffix,
                    financedproject: financedproject, room: room, lot: lot, buildingname: buildingname,
                    street: street, subdivision: subdivision, region: region, province: province, city: city,
                    district: district, brgy: brgy, postalcode: postalcode, roomproj: roomproj, lotproj: lotproj,
                    buildingnameproj: buildingnameproj, streetproj: streetproj, subdivisionproj: subdivisionproj,
                    regionproj: regionproj, provinceproj: provinceproj, cityproj: cityproj, districtproj: districtproj,
                    brgyproj: brgyproj, postalcodeproj: postalcodeproj},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        //alert((json.res));                        
                        //filltable();
                        //cleardepdiv();                                                
                        $("#esrequestid").val((json.res).substring((json.res).length, 5));
                        $("#addressid").val((json.resadd).substring((json.resadd).length, 5));
                        hidebuttonsacctab1();
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#clearsecinfo").on('click', function () {
            clearsectab1();
        });

        $("#clearaccinfo").on('click', function () {
            clearacctab1();
        });
        
        
         $("#program").click(function () {
            var avail = $("input[type='radio'][name='availlendprog']:checked").val();
            $.ajax({
                url: "DDProgramDataServlet",
                dataType: 'json',
                data: {avail: avail},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (programloaded)
                        return;
                    $("#program").empty();
                    $("#program").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#program").append("<option>" + list[i].lpDesc + "</option>");
                    }
                    programloaded = true;
                }
            });
        });

        $("#program").change(function () {
            var programdesc = $("#program").val();
            var id = '';
            clearGPcheckbox();
            $.ajax({
                url: "DDProgramGroupCodeServlet",
                dataType: 'json',
                data: {programdesc: programdesc},
                success: function (json) {
                    $('#programgroupcode').val(json.programcode);
                    $('#lendingprogramcode').val(json.lendingprogramcode);
                    
                    clearGPcheckbox();
                    clearSDGcheckbox();
                    clearallgroupdiv();
                    id = json.programcode;
                    document.getElementById('group' + id).style.display = "block";
                    var list = [];
                    list = json.gpdesc;
                    for (var i = 0; i < list.length; i++) {
                        document.getElementById('GP' + list[i].gpDesc).checked = true;
                    }
                    var list2 = [];
                    list2 = json.sdgdesc;
                    for (var i = 0; i < list2.length; i++) {
                        document.getElementById('SDG' + list2[i].sdgDesc).checked = true;
                    }
                }
            });
        });

        $("#group11_1").change(function () {
            if (this.value === 'Others') {
                document.getElementById("group11_1_others").style.display = "block";
            } else {
                document.getElementById("group11_1_others").style.display = "none";
            }
        });

        $("#typeofinvestment").change(function () {
            if (this.value === 'Others') {
                document.getElementById("typeinvothers").style.display = "block";
            } else {
                document.getElementById("typeinvothers").style.display = "none";
            }
        });
        
         $("#savepart2inv").on('click', function () {
	    var esrequestid = $("#esrequestid").val(); var lendinv = document.querySelector('input[name="lendinv"]:checked').value; var programgroupcode = $("#programgroupcode").val();	
	    var sectorprioritysector = ""; var typeofinvestmentsubsector = ""; var typeinvothers = ""; var availlendprog = "";var lendingprogramcode = ""; var group1_1= $("#group1_1").val();
    	    var group1_2= $("#group1_2").val(); var group1_3= $("#group1_3").val(); var group2_1= $("#group2_1").val(); var group2_2= $("#group2_2").val(); var group2_3= $("#group2_3").val();
    	    var group2_4= $("#group2_4").val(); var group2_5= $("#group2_5").val(); var group2_6= $("#group2_6").val(); var group3_1= $("#group3_1").val(); var group3_2= $("#group3_2").val();
    	    var group3_3= $("#group3_3").val(); var group4_1= $("#group4_1").val(); var group4_2= $("#group4_2").val(); var group4_3= $("#group4_3").val(); var group4_4= $("#group4_4").val();
    	    var group4_5= $("#group4_5").val(); var group4_6= $("#group4_6").val(); var group5_1= $("#group5_1").val(); var group6_1= $("#group6_1").val(); var group6_2= $("#group6_2").val();
    	    var group6_3= $("#group6_3").val(); var group7_1= $("#group7_1").val(); var group7_2= $("#group7_2").val(); var group7_3= $("#group7_3").val(); var group7_4= $("#group7_4").val();
    	    var group7_5= $("#group7_5").val(); var group7_6= $("#group7_6").val(); var group8_1= $("#group8_1").val(); var group8_2= $("#group8_2").val(); var group8_3= $("#group8_3").val();
    	    var group8_4= $("#group8_4").val(); var group8_5= $("#group8_5").val(); var group9_1= $("#group9_1").val(); var group9_2= $("#group9_2").val(); var group9_3= $("#group9_3").val();
    	    var group9_4= $("#group9_4").val(); var group10_1= $("#group10_1").val(); var group10_2= $("#group10_2").val(); var group11_1= $("#group11_1").val(); var group11_1_others= $("#group11_1_others").val();
    	    var group11_2= $("#group11_2").val(); var group11_3= $("#group11_3").val(); var group12_1= $("#group12_1").val(); var group12_2= $("#group12_2").val(); var group12_3= $("#group12_3").val();
    	    var group13_1= $("#group13_1").val(); var group13_2= $("#group13_2").val(); var group13_3= $("#group13_3").val(); var group14_1= $("#group14_1").val(); var group14_2= $("#group14_2").val();
    	    var group14_3= $("#group14_3").val(); var group14_4= $("#group14_4").val(); var group14_5= $("#group14_5").val(); var group15_1= $("#group15_1").val(); var group16_1= $("#group16_1").val();
    	    var group16_2= $("#group16_2").val(); var group16_3= $("#group16_3").val(); var group16_4= $("#group16_4").val(); var group17_1= $("#group17_1").val(); var group17_2= $("#group17_2").val();
    	    var group17_3= $("#group17_3").val(); var group17_4= $("#group17_4").val(); var group18_1= $("#group18_1").val(); var group18_2= $("#group18_2").val(); var group18_3= $("#group18_3").val();
    	    var group18_4= $("#group18_4").val(); var group18_5= $("#group18_5").val(); var GP1 = $("#GP1").is(":checked"); var GP2 = $("#GP2").is(":checked"); var GP3 = $("#GP3").is(":checked");
            var GP4 = $("#GP4").is(":checked"); var GP5 = $("#GP5").is(":checked"); var GP6 = $("#GP6").is(":checked"); var GP7 = $("#GP7").is(":checked"); var SDG1 = $("#SDG1").is(":checked");
            var SDG2 = $("#SDG2").is(":checked"); var SDG3 = $("#SDG3").is(":checked"); var SDG4 = $("#SDG4").is(":checked"); var SDG5 = $("#SDG5").is(":checked"); var SDG6 = $("#SDG6").is(":checked");
            var SDG7 = $("#SDG7").is(":checked"); var SDG8 = $("#SDG8").is(":checked"); var SDG9 = $("#SDG9").is(":checked"); var SDG10 = $("#SDG10").is(":checked"); var SDG11 = $("#SDG11").is(":checked");
            var SDG12 = $("#SDG12").is(":checked"); var SDG13 = $("#SDG13").is(":checked"); var SDG14 = $("#SDG14").is(":checked"); var SDG15 = $("#SDG15").is(":checked");
            var SDG16 = $("#SDG16").is(":checked"); var SDG17 = $("#SDG17").is(":checked"); var SDG18 = $("#SDG18").is(":checked");
            
            if (esrequestid === "") {		
                alert("Request ID is required!");
                event.preventDefault();
                return false;
            }
	    if (lendinv === "Lending") {                                
		sectorprioritysector = document.getElementById("prioritysector").value;
		typeofinvestmentsubsector = document.getElementById("subsector").value;
		availlendprog = document.querySelector('input[name="availlendprog"]:checked').value;                
		lendingprogramcode = document.getElementById("lendingprogramcode").value;	                
                    if (sectorprioritysector === "" || sectorprioritysector == 'blank') {		
                        alert("Priority Sector is required!");
                        event.preventDefault();
                        return false;
                    }                
                    if (typeofinvestmentsubsector === "" || typeofinvestmentsubsector == 'blank') {		
                        alert("Sub Sector is required!");
                        event.preventDefault();
                        return false;
                    }                            
            }
	    if (lendinv === "Investment") {                    
		sectorprioritysector = document.getElementById("sector").value;
		typeofinvestmentsubsector = document.getElementById("typeofinvestment").value;
		typeinvothers = document.getElementById("typeinvothers").value;

                    if (sectorprioritysector === "" || sectorprioritysector == 'blank') {		
                        alert("Sector is required!");
                        event.preventDefault();
                        return false;
                    }                
                    if (typeofinvestmentsubsector === "" || typeofinvestmentsubsector == 'blank') {		
                        alert("Type of Investment is required!");
                        event.preventDefault();
                        return false;
                    }  
                                                             
		    if (typeofinvestmentsubsector === "Others") {
			if (typeinvothers === "" || typeinvothers === null || typeinvothers === '') {
		                alert("Please supply other type of investment");
                		event.preventDefault();
		                return false;
		            }								
	            }	
            }	    	
            $.ajax({
                url: "Part2AddServlet",
                dataType: 'json',
                data: {esrequestid : esrequestid, sectorprioritysector : sectorprioritysector, typeofinvestmentsubsector : typeofinvestmentsubsector, typeinvothers : typeinvothers, 
		       availlendprog : availlendprog, lendingprogramcode : lendingprogramcode, group1_1 : group1_1, group1_2 : group1_2, group1_3 : group1_3, group2_1 : group2_1, 
		       group2_2 : group2_2, group2_3 : group2_3, group2_4 : group2_4, group2_5 : group2_5, group2_6 : group2_6, group3_1 : group3_1, group3_2 : group3_2, 
		       group3_3 : group3_3, group4_1 : group4_1, group4_2 : group4_2, group4_3 : group4_3, group4_4 : group4_4, group4_5 : group4_5, group4_6 : group4_6, 
		       group5_1 : group5_1, group6_1 : group6_1, group6_2 : group6_2, group6_3 : group6_3, group7_1 : group7_1, group7_2 : group7_2, group7_3 : group7_3, 
		       group7_4 : group7_4, group7_5 : group7_5, group7_6 : group7_6, group8_1 : group8_1, group8_2 : group8_2, group8_3 : group8_3, group8_4 : group8_4, 
		       group8_5 : group8_5, group9_1 : group9_1, group9_2 : group9_2, group9_3 : group9_3, group9_4 : group9_4, group10_1 : group10_1, group10_2 : group10_2, 
		       group11_1 : group11_1, group11_1_others : group11_1_others, group11_2 : group11_2, group11_3 : group11_3, group12_1 : group12_1, group12_2 : group12_2, 
		       group12_3 : group12_3, group13_1 : group13_1, group13_2 : group13_2, group13_3 : group13_3, group14_1 : group14_1, group14_2 : group14_2, group14_3 : group14_3, 
		       group14_4 : group14_4, group14_5 : group14_5, group15_1 : group15_1, group16_1 : group16_1, group16_2 : group16_2, group16_3 : group16_3, group16_4 : group16_4, 
		       group17_1 : group17_1, group17_2 : group17_2, group17_3 : group17_3, group17_4 : group17_4, group18_1 : group18_1, group18_2 : group18_2, group18_3 : group18_3, 
		       group18_4 : group18_4, group18_5 : group18_5, GP1 : GP1, GP2 : GP2, GP3 : GP3, GP4 : GP4, GP5 : GP5, GP6 : GP6, GP7 : GP7, SDG1 : SDG1, SDG2 : SDG2, SDG3 : SDG3, 
		       SDG4 : SDG4, SDG5 : SDG5, SDG6 : SDG6, SDG7 : SDG7, SDG8 : SDG8, SDG9 : SDG9, SDG10 : SDG10, SDG11 : SDG11, SDG12 : SDG12, SDG13 : SDG13, SDG14 : SDG14, 
		       SDG15 : SDG15, SDG16 : SDG16, SDG17 : SDG17, SDG18 : SDG18, programgroupcode: programgroupcode, lendinv : lendinv},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        //alert((json.res));                        
                        //filltable();
                        //cleardepdiv();                                                
                        $("#part2recordid").val((json.res).substring((json.res).length, 5));
                        //hidebuttonsacctab1();
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        }); 
                
        $("#lguproject").click(function () {
            $.ajax({
                url: "DDLGUProjectServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (lguprojectloaded)
                        return;
                    $("#lguproject").empty();
                    $("#lguproject").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#lguproject").append("<option>" + list[i].lguProjectDesc + "</option>");
                    }
                    lguprojectloaded = true;
                }
            });
        });

        $("#lguproject").change(function () {
            var lguproject = $("#lguproject").val();
            $.ajax({
                url: "DDLGUProjectCodeServlet",
                dataType: 'json',
                data: {lguproject: lguproject},
                success: function (json) {
                    $('#lguprojectcode').val(json.lpid);
                }
            });
        });        
        
        $("#savepart3").on('click', function () {            
            var lguprojectcode = $("#lguprojectcode").val();
            var alignsdg = document.querySelector('input[name="alignsdg"]:checked').value;            
            var esrequestid = $("#esrequestid").val(); 
            //var lendinv = document.querySelector('input[name="lendinv"]:checked').value;
            if (esrequestid === "") {		
                alert("Request ID is required!");
                event.preventDefault();
                return false;
            }
            if (lguprojectcode === "") {		
                alert("LGU Project is required!");
                event.preventDefault();
                return false;
            }                    
            $.ajax({
                url: "Part3AddServlet",
                dataType: 'json',
                data: {alignsdg: alignsdg,
                       lguprojectcode: lguprojectcode,                    
                       esrequestid: esrequestid},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));                                   
                        $("#part3recordid").val((json.res).substring((json.res).length, 5));
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });
        
        $("#savepart4").on('click', function () {                        
            var esrequestid = $("#esrequestid").val();
            var environmentalimpact = document.querySelector('input[name="environmentalimpact"]:checked').value; 
            var ecc = "";   
            var cnc = "";
            if (environmentalimpact === "Yes") {                
                ecc = document.querySelector('input[name="ecc"]:checked').value;                
                if (ecc === "" || ecc === null || ecc === '') {
                    alert("Please choose and option for ECC!");
                    event.preventDefault();
                    return false;                    
                }
            }
            if (environmentalimpact === "No") {
                cnc = document.querySelector('input[name="cnc"]:checked').value; 
                if (cnc === "" || cnc === null || cnc === '' ) {
                    alert("Please choose and option for CNC!");
                    event.preventDefault();
                    return false;                    
                }
            }    

            if (esrequestid === "") {		
                alert("Request ID is required!");
                event.preventDefault();
                return false;
            }                 
        
            $.ajax({
                url: "Part4AddServlet",
                dataType: 'json',
                data: {environmentalimpact: environmentalimpact,
                       ecc: ecc,                    
                       cnc: cnc,
                       esrequestid: esrequestid},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));                                   
                        $("#part4recordid").val((json.res).substring((json.res).length, 5));
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        function fillProjectAddress() {
            var financedproject = $("#financedproject").val();
            var roomproj = $("#roomproj").val();
            var lotproj = $("#lotproj").val();
            var buildingnameproj = $("#buildingnameproj").val();
            var streetproj = $("#streetproj").val();
            var subdivisionproj = $("#subdivisionproj").val();
            var regionproj = $("#regionproj").val();
            var provinceproj = $("#provinceproj").val();
            var cityproj = $("#cityproj").val();
            var districtproj = $("#districtproj").val();
            var brgyproj = $("#brgyproj").val();
            var postalcodeproj = $("#postalcodeproj").val();                        
            var projectaddress = "";
            var room = $("#room").val();
            var lot = $("#lot").val();
            var buildingname = $("#buildingname").val();
            var street = $("#street").val();
            var subdivision = $("#subdivision").val();
            var region = $("#region").val();
            var province = $("#province").val();
            var city = $("#city").val();
            var district = $("#district").val();
            var brgy = $("#brgy").val();
            var postalcode = $("#postalcode").val();                        
            var businessaddress = "";
            
            roomproj = roomproj == '' ? '' : roomproj + ', '; 
            lotproj = lotproj == '' ? '' : lotproj + ', '; 
            buildingnameproj = buildingnameproj == '' ? '' : buildingnameproj + ', '; 
            streetproj = streetproj == '' ? '' : streetproj + ', '; 
            subdivisionproj = subdivisionproj == '' ? '' : subdivisionproj + ', '; 
            regionproj = regionproj == 'blank' || regionproj == null ? '' : regionproj + ', '; 
            provinceproj = provinceproj == 'blank' || provinceproj ? '' : provinceproj + ', '; 
            cityproj = cityproj == 'blank' || cityproj == null ? '' : cityproj + ', '; 
            districtproj = districtproj == '' ? '' : districtproj + ', '; 
            brgyproj = brgyproj == 'blank' || brgyproj == null  ? '' : brgyproj + ', '; 
            postalcodeproj = postalcodeproj == '' ? '' : postalcodeproj; 
            projectaddress = roomproj + lotproj + buildingnameproj +streetproj + subdivisionproj + regionproj +provinceproj +cityproj + districtproj + brgyproj + postalcodeproj;            
            
            room = room == '' ? '' : room + ', '; 
            lot = lot == '' ? '' : lot + ', '; 
            buildingname = buildingname == '' ? '' : buildingname + ', '; 
            street = street == '' ? '' : street + ', '; 
            subdivision = subdivision == '' ? '' : subdivision + ', '; 
            region = region == 'blank' || region == null ? '' : region + ', '; 
            province = province == 'blank' || province ? '' : province + ', '; 
            city = city == 'blank' || city == null ? '' : city + ', '; 
            district = district == '' ? '' : district + ', '; 
            brgy = brgy == 'blank' || brgy == null  ? '' : brgy + ', '; 
            postalcode = postalcode == '' ? '' : postalcode;             
            businessaddress = room + lot + buildingname +street + subdivision + region +province +city + district + brgy + postalcode;
            
            $("#businessaddress").val(businessaddress);       
            $("#projectaddress").val(projectaddress);
            $("#partviProjectAddress").val(projectaddress);
            $("#partviProjectName").val(financedproject);                   
        };

        $("#postalcodeproj").blur(function () {
            fillProjectAddress();
        });    
        
        
        
        
         $("#M_NO_REG_EMPLOYEES").change(function () {
            var n = $("#M_NO_REG_EMPLOYEES").val();
            var o = $("#F_NO_REG_EMPLOYEES").val();                        
            var p = 0;
            if (o == "") {                
                o = 0;                
                }
            if (n == "") {
                n = 0;
            }   
            p = Number(n) + Number(o);
            $("#NO_REG_EMPLOYEES").val(p);
        });      
        
        $("#F_NO_REG_EMPLOYEES").change(function () {
            var n = $("#M_NO_REG_EMPLOYEES").val();
            var o = $("#F_NO_REG_EMPLOYEES").val();                        
            var p = 0;
            if (o == "") {                
                o = 0;                
                }
            if (n == "") {
                n = 0;
            }   
            p = Number(n) + Number(o);
            $("#NO_REG_EMPLOYEES").val(p);
        });        
    
        $("#M_NO_CONTRACT_EMPLOYEES").change(function () {
            var n = $("#M_NO_CONTRACT_EMPLOYEES").val();
            var o = $("#F_NO_CONTRACT_EMPLOYEES").val();                        
            var p = 0;
            if (o == "") {                
                o = 0;                
                }
            if (n == "") {
                n = 0;
            }   
            p = Number(n) + Number(o);
            $("#NO_CONTRACT_EMPLOYEES").val(p);
        });      
        
        $("#F_NO_CONTRACT_EMPLOYEES").change(function () {
            var n = $("#M_NO_CONTRACT_EMPLOYEES").val();
            var o = $("#F_NO_CONTRACT_EMPLOYEES").val();                        
            var p = 0;
            if (o == "") {                
                o = 0;                
                }
            if (n == "") {
                n = 0;
            }   
            p = Number(n) + Number(o);
            $("#NO_CONTRACT_EMPLOYEES").val(p);
        });            
    
        $("#M_NO_SUBCON_EMPLOYEES").change(function () {
            var n = $("#M_NO_SUBCON_EMPLOYEES").val();
            var o = $("#F_NO_SUBCON_EMPLOYEES").val();                        
            var p = 0;
            if (o == "") {                
                o = 0;                
                }
            if (n == "") {
                n = 0;
            }   
            p = Number(n) + Number(o);
            $("#NO_SUBCON_EMPLOYEES").val(p);
        });      
        
        $("#F_NO_SUBCON_EMPLOYEES").change(function () {
            var n = $("#M_NO_SUBCON_EMPLOYEES").val();
            var o = $("#F_NO_SUBCON_EMPLOYEES").val();                        
            var p = 0;
            if (o == "") {                
                o = 0;                
                }
            if (n == "") {
                n = 0;
            }   
            p = Number(n) + Number(o);
            $("#NO_SUBCON_EMPLOYEES").val(p);                       
        });               
        
        $("#CADT_CALT_REGION").click(function () {
            $.ajax({
                url: "DDRegionDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (CADT_CALT_REGIONloaded)
                        return;
                    $("#CADT_CALT_REGION").empty();
                    $("#CADT_CALT_REGION").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#CADT_CALT_REGION").append("<option>" + list[i].region + "</option>");
                    }
                    CADT_CALT_REGIONloaded = true;
                }
            });
        });

        $("#CADT_CALT_REGION").change(function () {
            var regiondesc = $("#CADT_CALT_REGION").val();  
            $("#CADT_CALT_NO").empty();
            $("#CADT_CALT_NO").val("");
            $("#CADT_CALT_TRIBE").val("");
            $("#CADT_CALT_LOCATION").val("");                 
            CADT_CALT_NOloaded = false;            
            $.ajax({
                url: "DDRegionCodeServlet",
                dataType: 'json',
                data: {x: regiondesc},
                success: function (json) {
                    $('#CADT_CALT_REGION_CODE').val(json.regcode);
                }
            });
        });

        $("#CADT_CALT_NO").click(function () {
            var regionid = $("#CADT_CALT_REGION_CODE").val();
            $("#CADT_CALT_TRIBE").val("");
            $("#CADT_CALT_LOCATION").val("");                 
            $.ajax({
                url: "DDCADTDataServlet",
                dataType: 'json',
                data: {x: regionid},
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (CADT_CALT_NOloaded)
                        return;
                    $("#CADT_CALT_NO").empty();
                    $("#CADT_CALT_NO").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#CADT_CALT_NO").append("<option>" + list[i].cadtNo + "</option>");
                    }
                    CADT_CALT_NOloaded = true;
                }
            });
        });    
    
        $("#CADT_CALT_NO").change(function () {
            var cadtno = $("#CADT_CALT_NO").val();                     
            $.ajax({
                url: "DDCADTDetailServlet",
                dataType: 'json',
                data: {x: cadtno},
                success: function (json) {
                    $("#CADT_CALT_TRIBE").val(json.tribe);
                    $("#CADT_CALT_LOCATION").val(json.location);                                         
                }
            });
        });
        
 $("#savepart5").on('click', function () { 
            var esrequestid = $("#esrequestid").val(); 
            var mNoRegEmployees = $("#M_NO_REG_EMPLOYEES").val(); 
            var fNoRegEmployees = $("#F_NO_REG_EMPLOYEES").val(); 
            var mNoContractEmployees = $("#M_NO_CONTRACT_EMPLOYEES").val(); 
            var fNoContractEmployees = $("#F_NO_CONTRACT_EMPLOYEES").val(); 
            var mNoSubconEmployees = $("#M_NO_SUBCON_EMPLOYEES").val(); 
            var fNoSubconEmployees = $("#F_NO_SUBCON_EMPLOYEES").val(); 
            var pracChildLabor = document.querySelector('input[name="PRAC_CHILD_LABOR"]:checked').value;                     
            var payingBelowMinWage = document.querySelector('input[name="PAYING_BELOW_MIN_WAGE"]:checked').value; 
            var landUsedIP = document.querySelector('input[name="LAND_USED_IP"]:checked').value;  
            var landUsedIPDetail = $("#LAND_USED_IP_DTL").val(); 
            var cadtCalt = document.querySelector('input[name="CADT_CALT"]:checked').value;                          
            var cadtCaltRegion = $("#CADT_CALT_REGION").val();
            var cadtCaltNo = $("#CADT_CALT_NO").val(); 
            var ipAffected = document.querySelector('input[name="IP_AFFECTED"]:checked').value; 
            var ipAffectedDTL = $("#IP_AFFECTED_DTL").val();
            var arbBene = document.querySelector('input[name="ARB_BENE"]:checked').value; 
            var arbBeneDTL = $("#ARB_BENE_DTL").val(); 
            var arbBorrower = document.querySelector('input[name="ARB_BORROWER"]:checked').value; 
            var arbBorrowerDTL = $("#ARB_BORROWER_DTL").val(); 
            var operateWoAuthLandTitle = document.querySelector('input[name="OPERATE_WO_AUTH_LAND_TITLE"]:checked').value; 
            var arbAffected = document.querySelector('input[name="ARB_AFFECTED"]:checked').value;  
            var arbAffectedDTL = $("#ARB_AFFECTED_DTL").val(); 
            var promoteGenderEquality = document.querySelector('input[name="PROMOTE_GENDER_EQUALITY"]:checked').value;  
            var promoteGenderEqualityDTL = $("#PROMOTE_GENDER_EQUALITY_DTL").val(); 
            var noWomenOwnership = $("#NO_WOMEN_OWNERSHIP").val(); 
            var noWomenDecisionBoard = $("#NO_WOMEN_DECISION_BOARD").val();
            var noWomenDecisionSeniorMGMT = $("#NO_WOMEN_DECISION_SENIOR_MGMT").val(); 
            var womenBene = document.querySelector('input[name="WOMEN_BENE"]:checked').value;  
            var womenBeneDTL = $("#WOMEN_BENE_DTL").val(); 
            var womenLongTermImpact = document.querySelector('input[name="WOMEN_LONG_TERM_IMPACT"]:checked').value;  
            var womenLongTermImpactDTL = $("#WOMEN_LONG_TERM_IMPACT_DTL").val(); 
            var womenMinImpact = document.querySelector('input[name="WOMEN_MIN_IMPACT"]:checked').value;  
            var womenMinImpactDTL = $("#WOMEN_MIN_IMPACT_DTL").val(); 
            var improvePrac = document.querySelector('input[name="IMPROVE_PRAC"]:checked').value; 
            var improvePracDTL = $("#IMPROVE_PRAC_DTL").val();                            
                                                 
                if (esrequestid === "") {		
                    alert("Request ID is required!");
                    event.preventDefault();
                return false;
                }                  
            $.ajax({
                url: "Part5AddServlet",
                dataType: 'json',
                data: {mNoRegEmployees: mNoRegEmployees, 
                       fNoRegEmployees: fNoRegEmployees, 
                       mNoContractEmployees: mNoContractEmployees, 
                       fNoContractEmployees: fNoContractEmployees,
                       mNoSubconEmployees: mNoSubconEmployees, 
                       fNoSubconEmployees: fNoSubconEmployees, 
                       pracChildLabor: pracChildLabor, 
                       payingBelowMinWage: payingBelowMinWage,
                       landUsedIP: landUsedIP, 
                       landUsedIPDetail: landUsedIPDetail, 
                       cadtCalt: cadtCalt, 
                       cadtCaltRegion: cadtCaltRegion, 
                       cadtCaltNo: cadtCaltNo, 
                       ipAffected: ipAffected,
                       ipAffectedDTL: ipAffectedDTL, 
                       arbBene: arbBene, 
                       arbBeneDTL: arbBeneDTL, 
                       arbBorrower: arbBorrower, 
                       arbBorrowerDTL: arbBorrowerDTL, 
                       operateWoAuthLandTitle: operateWoAuthLandTitle,
                       arbAffected: arbAffected, 
                       arbAffectedDTL: arbAffectedDTL, 
                       promoteGenderEquality: promoteGenderEquality, 
                       promoteGenderEqualityDTL: promoteGenderEqualityDTL,
                       noWomenOwnership: noWomenOwnership, 
                       noWomenDecisionBoard: noWomenDecisionBoard, 
                       noWomenDecisionSeniorMGMT: noWomenDecisionSeniorMGMT, 
                       womenBene: womenBene,
                       womenBeneDTL: womenBeneDTL, 
                       womenLongTermImpact: womenLongTermImpact, 
                       womenLongTermImpactDTL: womenLongTermImpactDTL, 
                       womenMinImpact: womenMinImpact,
                       womenMinImpactDTL: womenMinImpactDTL, 
                       improvePrac: improvePrac, 
                       improvePracDTL: improvePracDTL, 
                       esrequestid: esrequestid},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));                                   
                        $("#part5recordid").val((json.res).substring((json.res).length, 5));
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });                       
        });      
        
        
        
        modal.style.display = "none";
        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        
        
        
  $(document).ready(function () {
            setupTimers();
            function disableBack() {
                window.history.forward();
            }

            window.onload = disableBack();
            window.onpageshow = function (evt) {
                if (evt.persisted)
                    disableBack();
                setupTimers();
            };
        });

        
         
        
   

});


function startTimer() {
            // window.setTimeout returns an Id that can be used to start and stop a timer
            warningTimerID = window.setTimeout(warningInactive, warningTimeout);
        }

        function warningInactive() {
            window.clearTimeout(warningTimerID);
            timeoutTimerID = window.setTimeout(IdleTimeout, timoutNow);
            modal.style.display = "block";
        }

        function resetTimer() {
            window.clearTimeout(timeoutTimerID);
            window.clearTimeout(warningTimerID);
            startTimer();
        }
        // Logout the user.
        function IdleTimeout() {
            logoutUserStatusIdle();
            window.location.replace("/SFC/login");
        }

        function setupTimers() {
            document.addEventListener("mousemove", resetTimer, false);
            document.addEventListener("mousedown", resetTimer, false);
            document.addEventListener("keypress", resetTimer, false);
            document.addEventListener("touchmove", resetTimer, false);
            document.addEventListener("onscroll", resetTimer, false);
            startTimer();
        }

        $("#btnStayLoggedIn").on('click', function () {
            resetTimer();
            modal.style.display = "none";
            event.preventDefault();            
        });


  function logoutUserStatusIdle() {
            $.ajax({
                url: 'logout',
                async: true,
                type: 'POST',
                success: function (json) {
                    //localStorage.clear();
                }
            });
        } 
        
function clearGPcheckbox() {
            for (var i = 1; i < 8; i++) {
                document.getElementById('GP' + i).checked = false;
            }
        }
        ;

        function clearSDGcheckbox() {
            for (var i = 1; i < 19; i++) {
                document.getElementById('SDG' + i).checked = false;
            }
        }
        ;

        function clearallgroupdiv() {
            for (var i = 1; i < 19; i++) {
                document.getElementById('group' + i).style.display = "none";
            }
        }
        ;

        function clearresultindicators() {
            $('#resultindicators').find('input:text, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            $('#resultindicators').find("select").prop("selectedIndex", 0);

        }
        ;

        function clearpart2main() {
            $('#part2_main').find('input:text, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            $('#part2_main').find("select").prop("selectedIndex", 0);
        };
 


 function clearsectab1() {
            $('#tabs-1').find('input:text, input:password, select, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            $('#maindiv').find('input:text, input:password, select, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            hidebuttonsectab1();
        };

        function clearacctab1() {
            $('#tabs-2').find('input:text, input:password, select, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            $('#tabs-2').find('select')
                    .each(function () {
                        $(this).append("<option value=blank>Select Value</option>");
                    });
            $('#maindiv').find('input:text, input:password, select, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            hidebuttonsacctab1();
        };

        function hidebuttonsacctab1() {
            if ($("#esrequestid").val() != '' || $("#esrequestid").val() != 'blank') {
                $('#saveaccinfo').hide()
                $('#updateaccinfo').show()
                //$('#deleteaccinfo').show()
            }
            if ($("#esrequestid").val() == '' || $("#esrequestid").val() == 'blank') {
                $('#saveaccinfo').show();
                $('#updateaccinfo').hide();
                //$('#deleteclcreditfacilityview').hide()
            }
        };

        function hidebuttonsectab1() {
            if ($("#esrequestid").val() != '' || $("#esrequestid").val() != 'blank') {
                $('#savesecinfo').hide()
                $('#updatesecinfo').show()
                //$('#deleteaccinfo').show()
            }
            if ($("#esrequestid").val() == '' || $("#esrequestid").val() == 'blank') {
                $('#savesecinfo').show()
                $('#updatesecinfo').hide()
                //$('#deleteclcreditfacilityview').hide()
            }
        };

function hideadmin() {
            if ($("#isadmin").val() === 'N') {
                $('#busermaintenancepage').hide();
                $('#bupload').hide();
                document.getElementById("divlovmaintenance").style.display = "none";
            }
        };

function initYes(){
            // Use moment to get current date and format it
//        var formattedDate = moment().format('MMMM D, YYYY, h:mm A');
const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

//const d = new Date();
//
//        const date = new Date();
//        // Insert the formatted date into the span
//        document.getElementById('app-date-time').textContent = formattedDate;
        
const date = new Date();
const year = date.getFullYear();
const day = String(date.getDate()).padStart(2, '0');
let month = months[date.getMonth()];

const formattedDate = `${month} ${day}, ${year}`; 
 document.getElementById('app-date-time').textContent = formattedDate;       
        
}




function clearsectab1() {
    $('#tabs-1').find('input:text, input:password, select, input[type=date]')
        .each(function () {
        $(this).val(''); });
        $('#maindiv').find('input:text, input:password, select, input[type=date]')
            .each(function () {
                        $(this).val('');
                    });
            $("input[name=lendinv][value='Lending']").prop('checked', true);
            document.getElementById('lblinvestmentloanid').innerHTML = 'Loan ID*';
            document.getElementById("tabs-1").style.display = "none";
            document.getElementById("secinfo").style.display = "none";
            document.getElementById("accountinfo").style.display = "block";
            document.getElementById("tabs-2").style.display = "block";
            $('h4.manager').text('Create Sustainability Finance Checklist - Lending');
            hidebuttonsectab1();
}

function clearacctab1() {
    $('#tabs-2').find('input:text, input:password, select, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            $('#tabs-2').find('select')
                    .each(function () {
                        $(this).append("<option value=blank>Select Value</option>");
                    });
            $('#maindiv').find('input:text, input:password, select, input[type=date]')
                    .each(function () {
                        $(this).val('');
                    });
            hidebuttonsacctab1();
        }

        function hidebuttonsacctab1() {
            if ($("#esrequestid").val() !== '' || $("#esrequestid").val() !== 'blank') {
                $('#saveaccinfo').hide();
                $('#updateaccinfo').show();
                //$('#deleteaccinfo').show()
            }
            if ($("#esrequestid").val() === '' || $("#esrequestid").val() === 'blank') {
                $('#saveaccinfo').show();
                $('#updateaccinfo').hide();
                //$('#deleteclcreditfacilityview').hide()
            }
        };

        function hidebuttonsectab1() {
            if ($("#esrequestid").val() !== '' || $("#esrequestid").val() !== 'blank') {
                $('#savesecinfo').hide();
                $('#updatesecinfo').show();
                //$('#deleteaccinfo').show()
            }
            if ($("#esrequestid").val() === '' || $("#esrequestid").val() === 'blank') {
                $('#savesecinfo').show();
                $('#updatesecinfo').hide();
                //$('#deleteclcreditfacilityview').hide()
            }
}

 function clearallgroupdiv() {
            document.getElementById("group1").style.display = "none";
            document.getElementById("group2").style.display = "none";
            document.getElementById("group3").style.display = "none";
            document.getElementById("group4").style.display = "none";
            document.getElementById("group5").style.display = "none";
            document.getElementById("group6").style.display = "none";
            document.getElementById("group7").style.display = "none";
            document.getElementById("group8").style.display = "none";
            document.getElementById("group9").style.display = "none";
            document.getElementById("group10").style.display = "none";
            document.getElementById("group11").style.display = "none";
            document.getElementById("group12").style.display = "none";
            document.getElementById("group13").style.display = "none";
            document.getElementById("group14").style.display = "none";                                                                          
             document.getElementById("group15").style.display = "none";
             document.getElementById("group16").style.display = "none";
             document.getElementById("group17").style.display = "none";
             document.getElementById("group18").style.display = "none";             
}

function setUpTimer () {
    setupTimers();
    function disableBack() {
         window.history.forward();
    }
    window.onload = disableBack();
    window.onpageshow = function (evt) {
        if (evt.persisted)
            disableBack();
            setupTimers();
        };
}

function startTimer() {
            // window.setTimeout returns an Id that can be used to start and stop a timer
            warningTimerID = window.setTimeout(warningInactive, warningTimeout);
        }

        function warningInactive() {
            window.clearTimeout(warningTimerID);
            timeoutTimerID = window.setTimeout(IdleTimeout, timoutNow);
            modal.style.display = "block";
        }

        function resetTimer() {
            window.clearTimeout(timeoutTimerID);
            window.clearTimeout(warningTimerID);
            startTimer();
        }
        // Logout the user.
        function IdleTimeout() {
            logoutUserStatusIdle();
            window.location.replace("/SFC/login");
        }

        function setupTimers() {
            document.addEventListener("mousemove", resetTimer, false);
            document.addEventListener("mousedown", resetTimer, false);
            document.addEventListener("keypress", resetTimer, false);
            document.addEventListener("touchmove", resetTimer, false);
            document.addEventListener("onscroll", resetTimer, false);
            startTimer();
        }
        
        function logoutUserStatusIdle() {
            $.ajax({
                url: 'logout',
                async: true,
                type: 'POST',
                success: function (json) {
                    //localStorage.clear();
                }
            });
        }
        
    function confirmLogout() {
//        if (confirm('Are you sure you want to logout?')) {
            document.getElementById('logout-form').submit();
//        }
    }
