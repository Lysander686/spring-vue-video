<template>
  <div>
    <h1>Welcome to console </h1>
  </div>
</template>

<script>
  export default {
    name: "welcome",
    mounted() {
      console.log(this.$parent);
      this.$parent.activeSidebar("welcome-sidebar");
      
    },
    methods:{

    }
  }

</script>

<style scoped>

</style>