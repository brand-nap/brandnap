<template>
  <section id="new-landmark-container">
      <link rel="stylesheet" href='https://fonts.googleapis.com/css?family=Montserrat Alternates'>
      <div><h2 id="page-title">Submit a New Landmark for Consideration</h2></div>
      <div class="form-container">
      <form class="form" v-on:submit.prevent= "saveLandmark">
        <div class="status-message success" v-show="formAddedSuccess">Review successfully submitted</div> 
        <div class="status-message error" v-show="formAddedFailure">{{errorMessage}}</div>
          <div class="form-group">
            <label for="name">Name</label>
            <input class="form-control" id="name" type= "text" placeholder="Enter Landmark Name" v-model="newLandmark.name">
          </div>
          <div class="form-group">
            <label for="type">Type</label>  
            <select class="form-control" id="type" v-on:click="setType" v-model="typeId">
                <!-- v-model= "newLandmark.type" -->
                <option value="">Select Type</option>
                <option value="5">Amusement</option>
                <option value="1">Art</option>
                <option value="2">Educational</option>
                <option value="7">Historic</option>
                <option value="4">Outdoor</option>
                <option value="8">Restaurant</option>
                <option value="3">Shopping</option>
                <option value="6">Venue</option>
            </select>
          </div>
          <div class="form-group">
            <label for="imgUrl">Image URL</label>
            <input class="form-control" id="imgUrl" type= "url" placeholder="Enter Image Address" v-model="newLandmark.imgUrl">
          </div>
          <div class="form-group">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" rows="3" v-model= "newLandmark.description"></textarea>
          </div>    
          
          <label id="addressLabel" for="address">Landmark Address:</label>
          <div id="address" class="form-group">
              <div>
                <label for="street">Street</label>
                <input class="form-control" id="street" type="text" placeholder="street" v-model= "newLandmark.address.street">
              </div>
              <div>
                <label for="city">City</label>
                <input class="form-control" type="text" id="city" placeholder="city" v-model= "newLandmark.address.city">
              </div>
              <div>
                <label for="state">State</label>
                <input class="form-control" type="text" id="state" placeholder="ex: MN" v-model= "newLandmark.address.state">
              </div>
              <div>
                <label id="zip-title" for="zip">Zip Code</label>
                <input class="form-control" type="number" id="zip" placeholder="ex: 55401" v-model= "newLandmark.address.zip">
              </div>
          </div>
          
          <div>
            <button id="btnAddLandmark" type="submit">Add Landmark</button>
          </div>
      </form>
      </div>
  </section>
</template>

<script>
import LandmarkService from '../services/LandmarkService'

export default {
    // props: ["id"],
    data(){
        return {
            typeId: '',
            newLandmark: {
                name: '',
                type: {
                    id: '',
                    name: ''
                },
                imgUrl: '',
                description: '',
                address: {
                    street: '',
                    city: '',
                    state: '',
                    zip: ''
                },
                pending: true
            },
            formAddedSuccess: false,
            formAddedFailure: false,
            errorMessage: ''
        }
    },
    methods: {
        saveLandmark(){
            // const landmarkToAdd = {
            //     name: this.newLandmark.name,
            //     //trying to convert string to number
            //     type: parseInt(this.newLandmark.type),
            //     description: this.newLandmark.description,
            //     address: {
            //         street: this.newLandmark.address.street,
            //         city: this.newLandmark.address.city,
            //         state: this.newLandmark.address.state,
            //         zip: this.newLandmark.address.zip,
            //     },
            //     pending: true
            // }
                
            LandmarkService.addLandmark(this.newLandmark)

            .then(response => {
                //expect a 201 meaning created
                //changed to 200 based on what was being returned
                if(response.status === 200){
                    this.resetForm();
                    this.formAddedSuccess = true;
                }
            })
            .catch(error => {
                this.handleErrorResponse(error, "submitting")
                this.formAddedFailure = true;
            })


        },
        resetForm(){
          this.newLandmark = {};  
        },
        setType(){
            if(parseInt(this.typeId) === 1){
                this.newLandmark.type.id = 1;
                this.newLandmark.type.name = "Art";
            } else if (parseInt(this.typeId) === 2){
                this.newLandmark.type.id = 2;
                this.newLandmark.type.name = "Educational";
            } 
            else if (parseInt(this.typeId) === 3){
                this.newLandmark.type.id = 3;
                this.newLandmark.type.name = "Shopping";
            }
            else if (parseInt(this.typeId) === 4){
                this.newLandmark.type.id = 4;
                this.newLandmark.type.name = "Outdoor";
            }
            else if (parseInt(this.typeId) === 5){
                this.newLandmark.type.id = 5;
                this.newLandmark.type.name = "Amusement";
            }
            else if (parseInt(this.typeId) === 6){
                this.newLandmark.type.id = 6;
                this.newLandmark.type.name = "Venue";
            }
            else if (parseInt(this.typeId) === 7){
                this.newLandmark.type.id = 7;
                this.newLandmark.type.name = "Historic";
            }
            else if (parseInt(this.typeId) === 8){
                this.newLandmark.type.id = 8;
                this.newLandmark.type.name = "Restaurant";
            }

        },
        handleErrorResponse(error, verb) {
            if (error.response) {
                this.errorMessage = '';
                if(error.response.status === 500){
                    this.errorMessage = "Error " + verb + " landmark. An internal server error occurred.";
                } else if (error.response.status === 404){
                    this.errorMessage = "Error " + verb + " landmark. URL could not be found.";
                } else {
                    this.errorMessage = "Error " + verb + " landmark. Response received was '" +
                error.response.statusText +
                "'.";
                }
            } else if (error.request) {
                this.errorMessage = "Error " + verb + " landmark. Server could not be reached.";
            } else {
                this.errorMessage = "Error " + verb + " landmark. Request could not be created.";
            }
        }
            
            
    }
    
}
</script>

<style>

body{
  background-color: #F3FCED;
}


#new-landmark-container {
    border-top: #1fd6c1 5px solid;
    font-family: 'Montserrat Alternates', 'Franklin Gothic Medium', 'Arial Narrow', 'Arial', 'sans-serif';
    color: #004E64;
    
    display: flex;
    flex-direction: column;
    align-items: center;
}

h2 {
    text-align: center;
    width: 100vw;
    justify-self: center;
}

.note{
    padding: 10px;
    background-color: #004E64;
    border-radius: 8px;
    color: #F3FCED;
}


.form div {
    display: flex;
    justify-content: center;
}

#description{
    margin-bottom: 10px;
}

#addressLabel{
    margin-top: 10px;
    text-align: center;
    font-weight: bold;
}

#address {
    display: block;
    text-align: center;
}

#address div{
    padding: 5px;
}

#address div label{
    margin-right: 10px;
}

#btnAddLandmark{
    /* margin-top: 2%;
    margin-left: 10%;
    margin-right: 10%; */
    
    padding: 10px;
    background-color: #004E64;
    border-radius: 12px;
    color: #F3FCED;
    font-family: 'Montserrat Alternates', 'Franklin Gothic Medium', 'Arial Narrow', 'Arial', 'sans-serif';
    cursor: pointer;
    border: #004E64;
}

.status-message {
  border-radius: 5px;
  font-weight: bold;
  text-align: center;
  padding: 10px;
  width: 350px;
  margin: 0 auto 10px;
}
.status-message.success {
  background-color: #90EE90;
}
.status-message.error {
  background-color: #F08080;
}
.form-container {
    border: 5px #004E64 solid;
    border-radius: 15%;
    background: rgb(246, 242, 242);
    width: 650px;
    display: grid;
    grid-template-columns: repeat(36, 10px);
    grid-template-rows: repeat(60, 10px);
}

.form{
    grid-column-start:9;
 grid-row-start: 2;

}
#zip-title{
    width: 105px;
}




</style>