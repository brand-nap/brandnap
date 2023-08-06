<template>
  <div id="pending-landmarks-container">
      <h3>Pending Landmarks</h3>
      <div id="pending-landmark" v-for="landmark in this.$store.state.pendingLandmarks" :key="landmark.id">
          <div class="landmark-info"> 
            <h3>{{landmark.name}}</h3>
            <p>Type: {{landmark.type.name}}</p>
            <p>{{landmark.description}}</p>
            <p>Address: {{landmark.address.street}}
                {{landmark.address.city}},
                {{landmark.address.state}}
                {{landmark.address.zip}}
            </p>
          </div>
          <img :src="landmark.img_URL" alt="landmark image">
          <div class="approve-reject-btns">
            <button class="approve-btn" v-on:click="approveLandmark(landmark)">Approve Landmark</button>
            <button class="reject-btn" v-on:click="rejectLandmark(landmark.id)">Reject Landmark</button>
           </div>
      </div>
  </div>
</template>

<script>
import landmarkService from '../services/LandmarkService'

export default {
    created() {
        this.listPendingLandmarks();
    },
    methods: {
        listPendingLandmarks() {
            landmarkService.list()
            .then((response) => {
                this.$store.commit("SET_PENDING_LANDMARKS", response.data);
            })
        },
        approveLandmark(landmark){
            landmarkService.setPendingToTrue(landmark)
            .then((response)=> {
                if(response.status === 200){
                    alert("Landmark approved!");
                }
            })
        },
        rejectLandmark(id){
            landmarkService.deleteLandmark(id)
            .then((response)=> {
                if(response.status === 200){
                    alert("Landmark deleted.");
                }
            })
        }
    }
}
</script>

<style>

#pending-landmarks-container{
    border-top: #1fd6c1 5px solid;
    color: #004E64;
    font-family: 'Montserrat Alternates', 'Franklin Gothic Medium', 'Arial Narrow', 'Arial', 'sans-serif';
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

#pending-landmark{
    display: flex;
    gap: 1rem;
}

.approve-reject-btns{
    display: flex;
    flex-direction: column;
    gap: 1rem;
    color: #004E64;
    font-family: 'Montserrat Alternates', 'Franklin Gothic Medium', 'Arial Narrow', 'Arial', 'sans-serif';
}

.approve-reject-btns button {
    padding: 8px;
    border-radius: 12px;
    color: #F3FCED;
    background-color: #004E64;
    font-family: 'Montserrat Alternates', 'Franklin Gothic Medium', 'Arial Narrow', 'Arial', 'sans-serif';
}

.approve-reject-btns button:hover{
    cursor: pointer;
}

</style>