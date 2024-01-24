<template>
  <!--  html-->
  <div class="app">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Source+Han+Sans:wght@400;600;700&family=Source+Han+Serif:wght@400;600;700">
    <div class="container" ref="pdfContent">
      <!-- 个人信息部分 -->
      <div class="personal">
        <h1>{{ person.name }}</h1><span> · </span>
        <p>{{ person.job }}</p>
      </div>

      <!-- 个人联系信息和个人介绍 -->
      <div class="personal-info">
        <div class="left-col">
          <p>
            <span v-for="(item, index) in personalInfo.leftCols" :key="index">
              {{ item.key }}: {{ item.value }} <br>
            </span>
          </p>
        </div>
        <div class="right-col">
          <p class="personal-introduction">
            {{ personalInfo.rightCol?.personalIntroduction }}
          </p>
        </div>
      </div>

      <!-- 技术栈部分 -->
      <div class="skills-title">
        <h1 class="in-title">技术栈</h1>
      </div>
      <div class="technical-skills">
        <div class="right-col">
          <p>
              <span v-for="skill in technicalSkills" :key="skill.key">
                 <span v-if="skill.key">{{ skill.key }}: </span><span>{{ skill.value }}</span><br>
              </span>
          </p>
        </div>
      </div>

      <!-- 工作经历部分 -->
      <div class="work-experience">
        <h2 class="in-title">工作&项目经历</h2>

        <div v-for="(company, index) in workExperience" :key="index">
          <!-- 公司名称及职位 -->
          <div class="job">
            <p><strong>{{ company.position }} · {{ company.companyName }}</strong></p>
            <p class="job-date">{{ company.startDate }} - {{ company.endDate }}</p>
          </div>
          <!-- 公司总结 -->
          <div class="job-summary">
            <p>{{ company.summary }}</p>
          </div>
          <!-- 项目总结 -->
          <div class="project-summary" v-for="(project, projectIndex) in company.projects" :key="projectIndex">
            <p><strong>{{ project.projectName }}</strong></p>
            <p>{{ project.projectSummary }}</p>
          </div>
          <!-- 工作经历详细内容 -->
          <ul>
            <li v-for="(responsibility, responsibilityIndex) in company.responsibilities" :key="responsibilityIndex">
              {{ responsibility }}
            </li>
          </ul>
        </div>
      </div>
      <!-- End 工作经历部分 -->

      <!-- 教育经历部分 -->
      <div class="education">
        <h2 class="in-title">教育经历</h2>
        <p>
          <span>{{ education.school }}</span>
          <span>{{ education.degree }}·{{ education.major }}</span>
          <span>{{ education.graduationDate }}</span>
        </p>
      </div>
      <!-- End 教育经历部分 -->
    </div>
  </div>
  <div>
    <!-- 打印 PDF 按钮 -->
    <button @click="generatePDF">生成 PDF</button>
  </div>
</template>

<script lang="ts">
import yaml from 'js-yaml';
import html2pdf from 'html2pdf.js';

export default {
  name: "Resume",
  props: {
    newYaml: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      person: {
        name: '',
        job: ''
      },
      personalInfo: {
        leftCols: [
          {key: '', value: ''}, // 初始化一个对象
        ],
        rightCol: {
          personalIntroduction: ""
        }
      },
      technicalSkills: [
        {key: '', value: ''}, // 初始化一个对象
      ],
      workExperience: [
        {
          companyName: '',
          position: '',
          startDate: '',
          endDate: '',
          summary: '',
          projects: [
            {
              projectName: '',
              projectSummary: '',
            },
          ],
          responsibilities: [
            '',
          ],
        },
      ],
      education: {
        school: '',
        degree: '',
        major: '',
        graduationDate: ''
      }
    };
  },
  watch: {
    newYaml: "updateResume",
  },
  mounted() {
    this.updateResume(this.newYaml);
  },
  methods: {
    updateResume(newYaml: string) {
      // console.log('Received YAML:', newYaml);
      try {
        const parsedData = yaml.load(newYaml);
        if (parsedData) {
          this.person = parsedData.person || this.person;
          this.personalInfo = parsedData.personalInfo || this.personalInfo;
          this.technicalSkills = parsedData.technicalSkills || this.technicalSkills;
          this.workExperience = parsedData.workExperience || this.workExperience;
          this.education = parsedData.education || this.education;
        }
      } catch (error) {
        console.error('解析 YAML 数据时发生错误:', error);
      }
    },
    generatePDF() {
      const content = this.$refs.pdfContent;
      html2pdf(content, {
        margin: [15, 10, 15, 0],// 单独设置上边距为15mm
        filename: '简历.pdf',
        image: {type: 'jpeg', quality: 0.98},
        html2canvas: {scale: 2},
        jsPDF: {unit: 'mm', format: 'a4', orientation: 'portrait'}
      });
    }
  },
}
</script>

<style>
@import './resume.css';
</style>