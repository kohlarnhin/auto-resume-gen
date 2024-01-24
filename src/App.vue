<template>
  <!--  html-->
  <div class="app">
      <!-- 左侧区域：Write Resume -->
      <div class="left-area">
        <WriteResume @updateResume="updateResumeYaml" />
      </div>
      <!-- 右侧区域：Resume -->
      <div class="right-area">
        <Resume :newYaml="resumeYaml" />
      </div>
  </div>
</template>

<script lang="ts">
import Resume from "./components/resume/Resume.vue";
import WriteResume from "./components/resume/WriteResume.vue";

export default {
  name: "App",
  components: {Resume, WriteResume},
  data() {
    return {
      resumeYaml: '', // 初始化为一个空字符串
    };
  },
  methods: {
    updateResumeYaml(newYaml: string) {
      this.resumeYaml = newYaml;
    },
  },
}
</script>

<style scoped>
.app {
  width: 80%;
  margin: auto;
  display: flex;
  justify-content: space-between;
}

.left-area, .right-area {
  width: 50%;
  padding: 20px;
  box-sizing: border-box;
}
</style>