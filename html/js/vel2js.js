function v2js_announcements(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<h3 class="');
t.p( context.announce.type);
t.p('">');
t.p( context.announce.message);
t.p('</h3>');
return t.toString();
}
function v2js_listDates(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.years.length; i1++) {
var year = context.years[i1];
velocityCount = i1;
t.p('    <optgroup label="');
t.p( year.year);
t.p('">    ');
for (var i2=0;  i2<year.months.length; i2++) {
var month = year.months[i2];
velocityCount = i2;
t.p('        <option value="');
t.p( month);
t.p('/');
t.p( year.year);
t.p('">');
t.p( month);
t.p('/');
t.p( year.year);
t.p('</option>    ');
}
velocityCount = i1;
t.p('    </optgroup>');
}
velocityCount = 0;
return t.toString();
}
function v2js_listInsertStatements(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.patients.length; i1++) {
var patient = context.patients[i1];
velocityCount = i1;
t.p('    insert into patient (rep_id, first_name, last_name, repository) values ( \'');
t.p( patient.id);
t.p('\', \'');
t.p( patient.name);
t.p('\',null,\'');
t.p( context.repository);
t.p('\');    <br/>  ');
}
velocityCount = 0;
return t.toString();
}
function v2js_listPatientAllergies(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<table cellpadding="0" cellspacing="0" border="0" class="display" id="allergies');
t.p( context.patient_id);
t.p('"><thead><tr><th>Product</th><th>Reaction</th></tr></thead><tbody>');
for (var i1=0;  i1<context.allergies.length; i1++) {
var allergy = context.allergies[i1];
velocityCount = i1;
t.p('<tr class="gradeX"><td value="');
t.p( allergy.product.value);
t.p('">');
t.p( allergy.product.value);
t.p('</td><td value="');
t.p( allergy.reaction.value);
t.p('">');
t.p( allergy.reaction.value);
t.p('</td></tr>');
}
velocityCount = 0;
t.p('</tbody><table>');
return t.toString();
}
function v2js_listPatientHistory(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.patient_history.length; i1++) {
var history = context.patient_history[i1];
velocityCount = i1;
t.p('     	');
if (history.color) {
t.p('  		<td style="background-color:');
t.p( history.color);
t.p('">');
t.p( history.title);
t.p('  	');
}
else {
t.p('		<td>');
t.p( history.title);
t.p('   	');
}
t.p('   	<div style="display: none;" class="ui-corner-all" id="detail">');
t.p( history.note);
t.p('</div></td> ');
}
velocityCount = 0;
return t.toString();
}
function v2js_listPatientHistoryTable(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
var count = 0;
for (var i1=0;  i1<context.patient_history.length; i1++) {
var history = context.patient_history[i1];
velocityCount = i1;
t.p('		');
if (count == 0) {
t.p('		<table cellpadding="0" cellspacing="0" border="0" class="display" id="history');
t.p( history.patient_id);
t.p('">		<thead><tr><th>History Title</th><th>Note</th><th>Priority</th></tr></thead><tbody>	');
}
t.p('	<tr class="gradeX">	<td value="');
t.p( history.title);
t.p('">');
t.p( history.title);
t.p('</td>	<td value="');
t.p( history.note);
t.p('">');
t.p( history.note);
t.p('</td>	<td value="');
t.p( history.priority);
t.p('">');
t.p( history.priority);
t.p('</td>	</tr>	');
count = ( count + 1 );
t.p('	');
}
velocityCount = 0;
t.p('</tbody><table>');
return t.toString();
}
function v2js_listPatientMeds(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example');
t.p( context.id);
t.p('"><thead><tr><th></th><th></th></tr></thead><tbody><tr class="gradeX"><td>Patient ID</td><td value="');
t.p( context.id);
t.p('">');
t.p( context.id);
t.p('</td></tr><tr class="gradeX"><td>Patient Name</td><td value="');
t.p( context.name.given);
t.p(' ');
t.p( context.name.lastname);
t.p('">');
t.p( context.name.given);
t.p(' ');
t.p( context.name.lastname);
t.p('</td></tr><tr class="gradeX"><td>Gender</td><td value="');
t.p( context.gender.displayName);
t.p('">');
t.p( context.gender.displayName);
t.p('</td></tr><tr class="gradeX"><td>Birth Date</td><td value="');
t.p( context.birthtime.month);
t.p('/');
t.p( context.birthtime.day);
t.p('/');
t.p( context.birthtime.year);
t.p(' ');
t.p( context.birthtime.hour);
t.p(':');
t.p( context.birthtime.minute);
t.p('">');
t.p( context.birthtime.month);
t.p('/');
t.p( context.birthtime.day);
t.p('/');
t.p( context.birthtime.year);
t.p(' ');
t.p( context.birthtime.hour);
t.p(':');
t.p( context.birthtime.minute);
t.p('</td></tr></tbody><table>');
return t.toString();
}
function v2js_listPatientMedsVert(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<table cellpadding="0" cellspacing="0" border="0" class="display" id="medications');
t.p( context.patient_id);
t.p('"><thead><tr><th></th><th></th><th></th></tr></thead><tbody>');
for (var i1=0;  i1<context.medications.length; i1++) {
var medication = context.medications[i1];
velocityCount = i1;
t.p('<tr class="gradeX"><td>');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td><td>Manufacturer Info</td><td value="');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('">');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td></tr><tr class="gradeX"><td>');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td><td>Patient Information</td><td value="');
t.p( medication.patientInstructions);
t.p('">');
t.p( medication.patientInstructions);
t.p('</td></tr><tr class="gradeX"><td>');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td><td>Effective Time</td><td value="');
t.p( medication.effectiveTime.value);
t.p('">');
t.p( medication.effectiveTime.value);
t.p('</td></tr><tr class="gradeX"><td>');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td><td>Dose</td><td value="');
t.p( medication.dose.value);
t.p('">');
t.p( medication.dose.value);
t.p('</td></tr><tr class="gradeX"><td>');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td><td>Delivery Method</td><td value="');
t.p( medication.deliveryMethod.value);
t.p('">');
t.p( medication.deliveryMethod.value);
t.p('</td></tr><tr class="gradeX"><td>');
t.p( medication.medicationInformation.manufacturedMaterial.freeTextBrandName);
t.p('</td><td>Narrative</td><td value="');
t.p( medication.narrative);
t.p('">');
t.p( medication.narrative);
t.p('</td></tr>');
}
velocityCount = 0;
t.p('</tbody><table>');
return t.toString();
}
function v2js_listPatientTable(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example');
t.p( context.patient_id);
t.p('"><thead><tr><th></th><th></th></tr></thead><tbody><tr class="gradeX"><td>Patient ID</td><td value="');
t.p( context.patient_id);
t.p('">');
t.p( context.patient_id);
t.p('</td></tr><tr class="gradeX"><td>Patient Name</td><td value="');
t.p( context.patient_data.name.given);
t.p(' ');
t.p( context.patient_data.name.lastname);
t.p('">');
t.p( context.patient_data.name.given);
t.p(' ');
t.p( context.patient_data.name.lastname);
t.p('</td></tr><tr class="gradeX"><td>Gender</td><td value="');
t.p( context.patient_data.gender.displayName);
t.p('">');
t.p( context.patient_data.gender.displayName);
t.p('</td></tr><tr class="gradeX"><td>Birth Date</td><td value="');
t.p( context.patient_data.birthtime.month);
t.p('/');
t.p( context.patient_data.birthtime.day);
t.p('/');
t.p( context.patient_data.birthtime.year);
t.p(' ');
t.p( context.patient_data.birthtime.hour);
t.p(':');
t.p( context.patient_data.birthtime.minute);
t.p('">');
t.p( context.patient_data.birthtime.month);
t.p('/');
t.p( context.patient_data.birthtime.day);
t.p('/');
t.p( context.patient_data.birthtime.year);
t.p(' ');
t.p( context.patient_data.birthtime.hour);
t.p(':');
t.p( context.patient_data.birthtime.minute);
t.p('</td></tr></tbody><table>');
return t.toString();
}
function v2js_listPatientsBookmarksTable(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<form id="bookmarkForm');
t.p( context.patient);
t.p('" name="bookmarkForm');
t.p( context.patient);
t.p('"><input type="submit" value="save"></input><table cellpadding="0" cellspacing="0" border="0" class="display" id="bookmarks');
t.p( context.patient);
t.p('"><thead><tr><th>Bookmark</th><th>URL</th><th>Description</th></tr></thead><tbody>');
if (!( context.bookmarks )) {
t.p('	<tr class="gradeX"><td name="name" value=""></td>    <td name="url" value=""></td>    <td name="description" value=""></td></tr>');
}
else {
for (var i1=0;  i1<context.bookmarks.length; i1++) {
var bookmark = context.bookmarks[i1];
velocityCount = i1;
t.p('    <tr class="gradeX"><td name="name" value="');
t.p( bookmark.name);
t.p('">');
t.p( bookmark.name);
t.p('</td>    <td name="url" value="');
t.p( bookmark.url);
t.p('">');
t.p( bookmark.url);
t.p('</td>    <td name="description" value="');
t.p( bookmark.description);
t.p('">');
t.p( bookmark.description);
t.p('</td></tr>');
}
velocityCount = 0;
}
t.p('</tbody></table></form>');
return t.toString();
}
function v2js_listPatientsTable(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example');
t.p( context.repository);
t.p('"><thead><tr><th></th><th></th></tr></thead><tbody>');
for (var i1=0;  i1<context.patients.length; i1++) {
var patient = context.patients[i1];
velocityCount = i1;
t.p('    <tr class="gradeX"><td value="');
t.p( patient.id);
t.p('"><span class="summary"><a href="');
t.p('#" class="details">');
t.p( patient.id);
t.p('</a></span></td><td value="');
t.p( patient.name);
t.p('">');
t.p( patient.name);
t.p('</td></tr>');
}
velocityCount = 0;
t.p('</tbody></table>');
return t.toString();
}
function v2js_listRepositorySelect(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<select id="repositorySelect"><option value="">--Select--</option>');
for (var i1=0;  i1<context.repositories.length; i1++) {
var repository = context.repositories[i1];
velocityCount = i1;
t.p('    <option value="');
t.p( repository.name);
t.p('">');
t.p( repository.name);
t.p('</option>');
}
velocityCount = 0;
t.p('</search>');
return t.toString();
}
function v2js_listSearchPatientsSelect(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
t.p('<select id="patientsList"><option value="">--Select--</option>');
for (var i1=0;  i1<context.patients.length; i1++) {
var patient = context.patients[i1];
velocityCount = i1;
t.p('    <option value="');
t.p( patient.id);
t.p('">');
t.p( patient.first_name);
t.p(' ');
t.p( patient.last_name);
t.p('</option>');
}
velocityCount = 0;
t.p('</search>');
return t.toString();
}
function v2js_listWidgets(context) { 
var t = new StringCat();
var velocityCount = 0;
if (context.velocityCount) velocityCount=context.velocityCount;
for (var i1=0;  i1<context.widgets.length; i1++) {
var widget = context.widgets[i1];
velocityCount = i1;
t.p('    <div class="imageContain">    	<img src="');
t.p( widget.image);
t.p('" alt="');
t.p( widget.name);
t.p('" custom:url="');
t.p( widget.clickURL);
t.p('" custom:type="');
t.p( widget.type);
t.p('" custom:Id="');
t.p( widget.id);
t.p('" custom:params="');
t.p( widget.params);
t.p('" custom:repository="');
t.p( widget.repository);
t.p('"></img>    	<p>');
t.p( widget.name);
t.p('</p>    </div><br/>  ');
}
velocityCount = 0;
return t.toString();
}
