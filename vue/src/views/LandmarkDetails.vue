<template>
  <div>
  <landmark-details/>
  <!-- <landmarks/> -->
  <reviews />
  </div>
</template>

<script>
import LandmarkDetails from '../components/LandmarkDetails.vue'
import Reviews from '../components/Reviews.vue'
//import Landmarks from '../components/Landmarks.vue'
export default {
  components: {
       LandmarkDetails,
       Reviews
    //Landmarks 
},

}
</script>

<style>

</style>