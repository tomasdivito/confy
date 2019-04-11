<template>
  <div>
    <content-placeholders>
      <content-placeholders-heading :img="true" />
      <content-placeholders-text :lines="3" />
    </content-placeholders>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Conferences",
  data() {
    return {
      conferencesByYear: []
    }
  },
  created() {
    axios.get("/api/v1/conferences").then(response => {
      this.conferencesByYear = response.data;
    });
  }
};
</script>

<style>

</style>