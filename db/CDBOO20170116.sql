/*
SQLyog v10.2 
MySQL - 5.5.37 : Database - cdboo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cdboo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cdboo`;

/*Table structure for table `abc` */

DROP TABLE IF EXISTS `abc`;

CREATE TABLE `abc` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `create_by` varchar(100) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注信息',
  `del_flag` int(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `abc` */

/*Table structure for table `act_ge_bytearray` */

DROP TABLE IF EXISTS `act_ge_bytearray`;

CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_bytearray` */

insert  into `act_ge_bytearray`(`ID_`,`REV_`,`NAME_`,`DEPLOYMENT_ID_`,`BYTES_`,`GENERATED_`) values ('3bc4bb2ead4143d185ac459cf5d68e93',1,'test_audit.bpmn20.xml','bfbf91e71b594f758116859ae838df75','<?xml version=\'1.0\' encoding=\'UTF-8\'?>\r\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/test\">\r\n  <process id=\"test_audit\" name=\"流程审批测试流程\" isExecutable=\"true\">\r\n    <startEvent id=\"start\" name=\"启动审批\" activiti:initiator=\"apply\" activiti:formKey=\"/oa/testAudit/form\"/>\r\n    <endEvent id=\"end\" name=\"结束审批\"/>\r\n    <userTask id=\"modify\" name=\"员工薪酬档级修改\" activiti:assignee=\"${apply}\"/>\r\n    <userTask id=\"audit\" name=\"薪酬主管初审\" activiti:assignee=\"thinkgem\"/>\r\n    <exclusiveGateway id=\"sid-C28BB5F6-013D-4570-B432-61B380C1F46F\"/>\r\n    <userTask id=\"audit2\" name=\"集团人力资源部部长审核\" activiti:assignee=\"thinkgem\"/>\r\n    <exclusiveGateway id=\"sid-ED46FE41-A0FD-496D-86DC-2C97AF5735F0\"/>\r\n    <sequenceFlow id=\"sid-EF2F51BB-1D99-4F0B-ACF2-B6C1300A7D2B\" sourceRef=\"audit2\" targetRef=\"sid-ED46FE41-A0FD-496D-86DC-2C97AF5735F0\"/>\r\n    <userTask id=\"audit3\" name=\"集团人力资源部分管领导审核\" activiti:assignee=\"thinkgem\"/>\r\n    <exclusiveGateway id=\"sid-FE485B2D-9A23-4236-BD0D-D788CA6E30E4\"/>\r\n    <sequenceFlow id=\"sid-3DBCD661-5720-4480-8156-748BE0275FEF\" sourceRef=\"audit3\" targetRef=\"sid-FE485B2D-9A23-4236-BD0D-D788CA6E30E4\"/>\r\n    <userTask id=\"audit4\" name=\"集团总经理审批\" activiti:assignee=\"thinkgem\"/>\r\n    <exclusiveGateway id=\"sid-3F53B6BD-F8F3-496B-AC08-50630BD11477\"/>\r\n    <userTask id=\"apply_end\" name=\"薪酬档级兑现\" activiti:assignee=\"thinkgem\"/>\r\n    <sequenceFlow id=\"sid-02DB2AD9-1332-4198-AC8D-22A35169D15C\" sourceRef=\"audit4\" targetRef=\"sid-3F53B6BD-F8F3-496B-AC08-50630BD11477\"/>\r\n    <sequenceFlow id=\"sid-2AB7C01A-50EE-4AAC-8C8F-F6E1935B3DA7\" sourceRef=\"audit\" targetRef=\"sid-C28BB5F6-013D-4570-B432-61B380C1F46F\"/>\r\n    <sequenceFlow id=\"sid-36E50C8B-6C7C-4968-B02D-EBAA425BF4BE\" sourceRef=\"start\" targetRef=\"audit\"/>\r\n    <sequenceFlow id=\"sid-7D723190-1432-411D-A4A4-774225E54CD9\" name=\"是\" sourceRef=\"sid-3F53B6BD-F8F3-496B-AC08-50630BD11477\" targetRef=\"apply_end\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==1}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-D44CAD43-0271-4920-A524-9B8533E52550\" name=\"是\" sourceRef=\"sid-FE485B2D-9A23-4236-BD0D-D788CA6E30E4\" targetRef=\"audit4\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==1}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-53258502-43EE-4DE8-B1A4-DBD11922B8AF\" name=\"否\" sourceRef=\"sid-C28BB5F6-013D-4570-B432-61B380C1F46F\" targetRef=\"modify\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==0}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <exclusiveGateway id=\"sid-5FED02D6-C388-48C6-870E-097DB2131EA0\"/>\r\n    <sequenceFlow id=\"sid-163DBC60-DBC9-438B-971A-67738FB7715A\" sourceRef=\"modify\" targetRef=\"sid-5FED02D6-C388-48C6-870E-097DB2131EA0\"/>\r\n    <sequenceFlow id=\"sid-72258A41-203E-428C-B71D-CA3506252D73\" name=\"是\" sourceRef=\"sid-C28BB5F6-013D-4570-B432-61B380C1F46F\" targetRef=\"audit2\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==1}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-8448EF4A-B62E-4899-ABC2-0E2DB2AE6838\" name=\"重新申请\" sourceRef=\"sid-5FED02D6-C388-48C6-870E-097DB2131EA0\" targetRef=\"audit\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==1}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-A7589084-4623-4FEA-A774-00A70DDC1D20\" name=\"是\" sourceRef=\"sid-ED46FE41-A0FD-496D-86DC-2C97AF5735F0\" targetRef=\"audit3\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==1}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-FA618636-3708-4D0C-8514-29A4BB8BC926\" name=\"否\" sourceRef=\"sid-ED46FE41-A0FD-496D-86DC-2C97AF5735F0\" targetRef=\"modify\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==0}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-1525BFF4-3E9D-4D8A-BF80-1F63AFE16289\" name=\"否\" sourceRef=\"sid-FE485B2D-9A23-4236-BD0D-D788CA6E30E4\" targetRef=\"modify\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==0}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-35CC8C6C-1067-4398-991C-CCF955115965\" name=\"否\" sourceRef=\"sid-3F53B6BD-F8F3-496B-AC08-50630BD11477\" targetRef=\"modify\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==0}]]></conditionExpression>\r\n    </sequenceFlow>\r\n    <sequenceFlow id=\"sid-BDB0AAB2-7E50-4D35-80EE-CE0BECDD9F57\" sourceRef=\"apply_end\" targetRef=\"end\"/>\r\n    <sequenceFlow id=\"sid-44AFB9C1-4057-4C48-B1F2-1EC897A52CB7\" name=\"销毁\" sourceRef=\"sid-5FED02D6-C388-48C6-870E-097DB2131EA0\" targetRef=\"end\">\r\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${pass==0}]]></conditionExpression>\r\n    </sequenceFlow>\r\n  </process>\r\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_test_audit\">\r\n    <bpmndi:BPMNPlane bpmnElement=\"test_audit\" id=\"BPMNPlane_test_audit\">\r\n      <bpmndi:BPMNShape bpmnElement=\"start\" id=\"BPMNShape_start\">\r\n        <omgdc:Bounds height=\"30.0\" width=\"30.0\" x=\"30.0\" y=\"245.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"end\" id=\"BPMNShape_end\">\r\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"975.0\" y=\"356.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"modify\" id=\"BPMNShape_modify\">\r\n        <omgdc:Bounds height=\"58.0\" width=\"102.0\" x=\"209.0\" y=\"135.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"audit\" id=\"BPMNShape_audit\">\r\n        <omgdc:Bounds height=\"57.0\" width=\"96.0\" x=\"105.0\" y=\"231.5\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"sid-C28BB5F6-013D-4570-B432-61B380C1F46F\" id=\"BPMNShape_sid-C28BB5F6-013D-4570-B432-61B380C1F46F\">\r\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"240.0\" y=\"240.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"audit2\" id=\"BPMNShape_audit2\">\r\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"210.0\" y=\"330.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"sid-ED46FE41-A0FD-496D-86DC-2C97AF5735F0\" id=\"BPMNShape_sid-ED46FE41-A0FD-496D-86DC-2C97AF5735F0\">\r\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"345.0\" y=\"350.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"audit3\" id=\"BPMNShape_audit3\">\r\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"420.0\" y=\"330.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"sid-FE485B2D-9A23-4236-BD0D-D788CA6E30E4\" id=\"BPMNShape_sid-FE485B2D-9A23-4236-BD0D-D788CA6E30E4\">\r\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"555.0\" y=\"350.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"audit4\" id=\"BPMNShape_audit4\">\r\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"630.0\" y=\"330.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"sid-3F53B6BD-F8F3-496B-AC08-50630BD11477\" id=\"BPMNShape_sid-3F53B6BD-F8F3-496B-AC08-50630BD11477\">\r\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"765.0\" y=\"350.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"apply_end\" id=\"BPMNShape_apply_end\">\r\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"840.0\" y=\"330.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNShape bpmnElement=\"sid-5FED02D6-C388-48C6-870E-097DB2131EA0\" id=\"BPMNShape_sid-5FED02D6-C388-48C6-870E-097DB2131EA0\">\r\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"240.0\" y=\"45.0\"/>\r\n      </bpmndi:BPMNShape>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-3DBCD661-5720-4480-8156-748BE0275FEF\" id=\"BPMNEdge_sid-3DBCD661-5720-4480-8156-748BE0275FEF\">\r\n        <omgdi:waypoint x=\"520.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"555.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-44AFB9C1-4057-4C48-B1F2-1EC897A52CB7\" id=\"BPMNEdge_sid-44AFB9C1-4057-4C48-B1F2-1EC897A52CB7\">\r\n        <omgdi:waypoint x=\"280.0\" y=\"65.0\"/>\r\n        <omgdi:waypoint x=\"989.0\" y=\"65.0\"/>\r\n        <omgdi:waypoint x=\"989.0\" y=\"356.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-8448EF4A-B62E-4899-ABC2-0E2DB2AE6838\" id=\"BPMNEdge_sid-8448EF4A-B62E-4899-ABC2-0E2DB2AE6838\">\r\n        <omgdi:waypoint x=\"240.0\" y=\"65.0\"/>\r\n        <omgdi:waypoint x=\"153.0\" y=\"65.0\"/>\r\n        <omgdi:waypoint x=\"153.0\" y=\"231.5\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-A7589084-4623-4FEA-A774-00A70DDC1D20\" id=\"BPMNEdge_sid-A7589084-4623-4FEA-A774-00A70DDC1D20\">\r\n        <omgdi:waypoint x=\"385.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"420.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-35CC8C6C-1067-4398-991C-CCF955115965\" id=\"BPMNEdge_sid-35CC8C6C-1067-4398-991C-CCF955115965\">\r\n        <omgdi:waypoint x=\"785.0\" y=\"350.0\"/>\r\n        <omgdi:waypoint x=\"785.0\" y=\"164.0\"/>\r\n        <omgdi:waypoint x=\"311.0\" y=\"164.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-EF2F51BB-1D99-4F0B-ACF2-B6C1300A7D2B\" id=\"BPMNEdge_sid-EF2F51BB-1D99-4F0B-ACF2-B6C1300A7D2B\">\r\n        <omgdi:waypoint x=\"310.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"345.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-7D723190-1432-411D-A4A4-774225E54CD9\" id=\"BPMNEdge_sid-7D723190-1432-411D-A4A4-774225E54CD9\">\r\n        <omgdi:waypoint x=\"805.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"840.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-2AB7C01A-50EE-4AAC-8C8F-F6E1935B3DA7\" id=\"BPMNEdge_sid-2AB7C01A-50EE-4AAC-8C8F-F6E1935B3DA7\">\r\n        <omgdi:waypoint x=\"201.0\" y=\"260.0\"/>\r\n        <omgdi:waypoint x=\"240.0\" y=\"260.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-D44CAD43-0271-4920-A524-9B8533E52550\" id=\"BPMNEdge_sid-D44CAD43-0271-4920-A524-9B8533E52550\">\r\n        <omgdi:waypoint x=\"595.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"630.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-FA618636-3708-4D0C-8514-29A4BB8BC926\" id=\"BPMNEdge_sid-FA618636-3708-4D0C-8514-29A4BB8BC926\">\r\n        <omgdi:waypoint x=\"365.0\" y=\"350.0\"/>\r\n        <omgdi:waypoint x=\"365.0\" y=\"164.0\"/>\r\n        <omgdi:waypoint x=\"311.0\" y=\"164.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-02DB2AD9-1332-4198-AC8D-22A35169D15C\" id=\"BPMNEdge_sid-02DB2AD9-1332-4198-AC8D-22A35169D15C\">\r\n        <omgdi:waypoint x=\"730.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"765.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-36E50C8B-6C7C-4968-B02D-EBAA425BF4BE\" id=\"BPMNEdge_sid-36E50C8B-6C7C-4968-B02D-EBAA425BF4BE\">\r\n        <omgdi:waypoint x=\"60.0\" y=\"260.0\"/>\r\n        <omgdi:waypoint x=\"105.0\" y=\"260.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-53258502-43EE-4DE8-B1A4-DBD11922B8AF\" id=\"BPMNEdge_sid-53258502-43EE-4DE8-B1A4-DBD11922B8AF\">\r\n        <omgdi:waypoint x=\"260.0\" y=\"240.0\"/>\r\n        <omgdi:waypoint x=\"260.0\" y=\"193.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-163DBC60-DBC9-438B-971A-67738FB7715A\" id=\"BPMNEdge_sid-163DBC60-DBC9-438B-971A-67738FB7715A\">\r\n        <omgdi:waypoint x=\"260.0\" y=\"135.0\"/>\r\n        <omgdi:waypoint x=\"260.0\" y=\"85.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-BDB0AAB2-7E50-4D35-80EE-CE0BECDD9F57\" id=\"BPMNEdge_sid-BDB0AAB2-7E50-4D35-80EE-CE0BECDD9F57\">\r\n        <omgdi:waypoint x=\"940.0\" y=\"370.0\"/>\r\n        <omgdi:waypoint x=\"975.0\" y=\"370.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-1525BFF4-3E9D-4D8A-BF80-1F63AFE16289\" id=\"BPMNEdge_sid-1525BFF4-3E9D-4D8A-BF80-1F63AFE16289\">\r\n        <omgdi:waypoint x=\"575.0\" y=\"350.0\"/>\r\n        <omgdi:waypoint x=\"575.0\" y=\"164.0\"/>\r\n        <omgdi:waypoint x=\"311.0\" y=\"164.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n      <bpmndi:BPMNEdge bpmnElement=\"sid-72258A41-203E-428C-B71D-CA3506252D73\" id=\"BPMNEdge_sid-72258A41-203E-428C-B71D-CA3506252D73\">\r\n        <omgdi:waypoint x=\"260.0\" y=\"280.0\"/>\r\n        <omgdi:waypoint x=\"260.0\" y=\"330.0\"/>\r\n      </bpmndi:BPMNEdge>\r\n    </bpmndi:BPMNPlane>\r\n  </bpmndi:BPMNDiagram>\r\n</definitions>',0),('7ba1daf4f43e434d82f8b3420aac2148',1,'test_audit.png','bfbf91e71b594f758116859ae838df75','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0|\0\0\0=ӳ�\0\0S�IDATx���|T����S����h�˲�l�e�ծZ1��4�X��K]��RVV�\"�Z/�\"\Z1�c\nĀ����D.I�c�1f��E��c��>�9�03�I2I��L^�����\\�\\2��>s>sΜ1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��/\0\0\0\0\0�+�,e�\0\0\0\0\0� ެ/�J����%\0\0\0\0�s�m�ɖ-ܟ�t\0\0\0\0�y�vk�\0\0\0\0�V$��T���n\0\0\0\0\0�l�[k���\r\0\0\0\0@��m�vz\0\0\0\0\0�m�=�����\0\0\0\0���κ=\0\0\0\0\0Q�����~\0\0\0\0\0��f��vgK7\0\0\0\0���=���̺����q 5\0\0\0\0@�o��x4���R�߶6݁nG�\r\0\0\0\0��Ͷ��j�UM�g�m�D���N7\0\0\0\0����k�[j��M��gz��\r\0\0\0\0�6�vBM�����Ͷo����\0\0\0\0���֦���;�f���?3��\r\0\0\0\0��f���n���G;�m��\0\0\0\0t�f������vG�\0\0\0\0\0a��[��5�i�}�n��\r\0\0\0\0],ά���6k�լ)�M����^v#�ݲ]e]�I���(��(*ʪάj�r�z�poh�E;�p��\Z���Ud��ƙu�Y}xyڤ������-�m���@��\r\0\0�h$}� ý���2[�:h�76���A��l5ڋͺ���C���3N�w���t�n\0\0\0t\'�J�ցg�r�+��o��o��d���`�(��/G)���(�\0\0\0�d�w�������\n�lg|��D6ݭ5����vk������\0\0@����w��yj�y>�jmskͶ�Φ�ޭ}�\0\0\0\04�zK�#�9@�|g���O�@[���l�tۏG�\r\0\0\0�����\'RCH���yB&�h�{��F������8|g\0\0\0hN��$^��l��h�o�=���<���6Z�?�\0\0\0&G/���+�8����l#�|w/�fy��O}�ޮ���\r\0\0\0t[YgƉ��Ysx¦��(��\0\0\0hN��gxp\"�!�9�Vt4ݝݼ\0\0\0�L֛syp\"�48:y8��n��F\0\0\0G�V^�ˀI��>�a�t����\0\0\0��>���\'��%+���n�\0\0\0\0�`��&z���D���\0\0\0�C`����f:���?��\0\0\0��\0C�m�f7r\0\0\0�~0tr�M�\r\0\0\0���Nn��h�\0\0\0�!0�й�Y��\0\0\0��\0C\'ʲ�U/^\n\0\0\0�~0t�8�\\[�\0\0\0�!0�Щ2��$���\0\0\0�7�8�u�.�\0\0\0�����i����|�\0\0\0���o�]�xy\0\0\0\0�!0��>��m�\"^\0\0\0�~0����|�\0\0\0���J���\0\0\0�!0���\0\0\0X��+\0\0\0�ul�Ƽ\0\0\0�:6``^\0\0\0�c��\0\0\0�:6�\0c^\0\0\0`00�\0\0\0\0ֱ�\0�\n\0\0\0``�1�\0\0\0\0��\r�W\0\0\0\0��`��y\0\0\0��\r0��W\0\0\0\0X��+\0\0\0�ul0���\0\0\0X�`�+\0\0\0\0�c��\0\0\0�:6``^\0\0\0�c0�\0\0\0\0ֱ�\0�\n\0\0\0`00�\0\0\0\0ֱ�\n\0\0\0\0��`��y\0\0\0��\r�W\0\0\0\0��\0�y\0\0\0��\r0��W�\0\0\0\0��`��y\0\0\0��\r�W\0\0\0\0��\0�y\0\0\0�ul0���\0\0\0X��+\0\0\0�ul�Ƽ\0\0\0�:6``^\0\0\0�c��\0\0\0�:6�\0c^\0\0\0`00�\0\0\0\0ֱ�\0�\n\0\0\0``�1�\0\0\0\0��\r�W\0\0\0\0��`��y\0\0\0��\r0��W\0\0\0\0X�,���R�SRRfN�8qolllC�޽��:P�P={�������l���Ϳ#�\0\0\0��\0��-[v�ȑ#�cbbԜ9�U~~�jh������:���,**T��ϩ�6������_L�\0\0\0@?X�JM}e}�~�TR���j4��&*���H����SO=�&�\0\0\0�!0���پ��TQ�v�	��\nq�����}��Üc�\0\0\0��\0�˖-�G�lm3�?�W-]��\Z3&A�\Zu����k�\r�#U�f�Q����SN��`�r\0\0\0����R�G���>)�y��7^�b�R5��ԭ���5v̍*>�Z5t�j�n���:��ޫW�<b\0\0\0�!0�\"\\J�11?R.W���5zU¨x�h�p�H�~�����aW�Mwl��Ω��>�Ss��=\0\0\0���&N��wΜ\'�F��f5bx�za�|��V�Jy1Ioپj�P}��v���{;�c5mڽ;�Y�H�\0\0\0@?X��Ґ��c6z\r���\'���Tm��������T�>s����C�?S\'�o�������ջ��0g�N�\0\0\0�!0�\"X�޽UC��f�W߬���*.ڢvoU�w���;vlW�=����P/��q=\0\0\0�����R_6+���j֬�j�o&���BU��]�v�P���o5�����_���Tǋ\0\0\0��\0����Ϋ\Z?W�ֽ�bc��?�TN�ϫJK�Ր�/U��NU\r\r�5�=��b�\0\0\0�!0������S�}wL��!]\r\Z�j���{e�U��*��?���W��W^2��4�{��W^���W�o����>��6\0\0\0��\r�1��n٤k[�켼��͌t�h�X�D��x�Jz�Y�̼�����P]{����5^�Au�X�\0\0�~��h����c�~��D.����ź�����-P�\'�S�;�I���Q3g�V=�ģf���~7�~���:^,�\0\0\0@?XT4�_8%\r�����ݬ�H{U7��|?;��;�	�ܳsu�-M���	js��V��Չł\r\0\0\0�C`�EE�}ԩ�{��G��~y�8�Pˮ��*.n�����zkwi�^�Au�X�\0\0�~��h�?�*�7S_~��J|�i�0�:5b��j��+TܕC�P�Ѿ������Qǎ�EO�{{��ł\r\0\0\0�C`�EE�}�\n�b�\0\0\0�!0������\n�b�\0\0\0�!0����>L�Y�`\0\0\0�`Q�p��\n�b�\0\0\0�!0����>D�Y�`\0\0\0�`Q�p�¬X�\0\0�~��h�PaVmwO��@<\0\0@?XX7��¬Zw�hm]��\0\0\0�C`��w�]�亅g����u��W�/+)��6���_ff�s:\'�u}��z[�۔�������z��K�Ϛ5��c͟?K�>th��uUU[��G��7{����f�UV��kj\n��\r��3�8������Zi�i�\0\0@?X�7ܟ���\r��eYY+�.���5y�̆�H�����;��r��sr��ٳ�JN��\\�n�ݧ���l6�o�3�<CO[]�U?��`n���\Z?�j[�i���v��+�z>ϕ+_pN�߿C����Wk�iyL��gϞ��}_��r~ʔ�tþ/����^�/��\'z�ѣ���Ͼ��G������s�E͘1�l��շ�����[�g���u\\(\0\0\0�~��m���-��LL|L��oٲ.�m�.���*6�����_��Ç�����yy�����*}^[ΟrJo�|�o6�w���J}��cX[��ԡC��˗,���KF��`���euu��oA�\Z�yH.�55�����[����Y�Xmذ��y��eg�R��Unn�~�r^�������?��w�9?PÆ]����|��/�zm�[�i�\0\0@?X�4�iVee�Ԟ=٪��c���ݡD���x������?�k��S99����9��N5��\nu��\'�;��lb�6��O����R����@����<O-\\���\\�w7�x�F���.W�*/߬/KM}N?VEş�u��җ��-R�_��y������ ���^�*����T�|�(�q�瓛�z��]����2����c�}yN׆F��(��(wՙ�Ǭl��1+ެ^���C`��Iý�Y-Y2O]tѿ�-[֨ի����n��=�A}^nSX����I��K^/e�-��-���=���c�^�����&%=��g���P��O�˦N�`}W�^���=}cc��&\\]]������Wx�\\�m�:=}v����f���z+��m��=[o��ˏ-Sk֤����U|�}�O~2H�}��oy.��\\nߗL\'���P�\\2�l�W{=�\\���X����5�sw��5Ƭ���5�YIf�c��#i��#��#�~��j�?iVr�]w�R�NK[��B{^�������.�0�j��_W_���]���~d���.+�v�����Ի\\��_�<�4��ٖ�U��U�^������+ӧ�η�Lo�\Z�~�?�8zt��}���|mm����iW�Nҧ��\\&���7^�O.[��I�h74|��O����X윗\r��j�����f��g>�\Z��7��AVt�a��;G�f}a�L^��#�~��n���Y��۝�ӧ��u]f��~o\'u���}q���v#+�rWW��v�\\���_�/^,����(V��̦�bUS�nV*��ý�ld?V))������oذT7��&ݦ�n�����J�y��\nש�.�P7��&<�j�6{}Ǝ�^�zk��,o���#�Tv�\n�h�zM�n��_���G�YY�~_�\0��w�w��-\r��a�Y��ڝ�rý�,9x?��\0�̆��Y�\'��P���[JK7��5fC[m6����Ʈ�\r���kk����Z?����l����j����v7�ǟKr򓺡ݷo�n�������y�.�if��l�?���>��8v��y^r��>`Z��Hg[�������Oy\\�~�w�B�V�_�`�3�\\��nu�e��fϞ�/������^���[�o��p&ߟ˲Vr\0�O+G��Ix?��\0�Ć�c�u�H���]�������\r\r��ÇK�M7��2e��<���ڞ{n}Z*--�:�z}CWz��,��ZC%�#��������Æ��l�SUFF�JM}F?�}�܇�w�^�u���?��µ�	��4�V]r?�&8�l��M����}�������[�x���{��kc��=c6�����{�u�P��7o����{���Vjժ��QCS^�1}�?�Vrd���k�eK�#�\0�G\0�`�pW{UN�\nݼ����t�lv��fڴ�������M�\Z?������>��j8_�w�|�|II�>�r}h�;K�oj�r�)(x��6<����<����u���}��|w��&O�����;��c�?0��������m�����ת[o����ۗWTd����B7���z�����1&��}jp�\Z��9����C`�E\\��QDUSӇ�2M��K{���q\'�IbqtH29x?��\0�����\n���q\'G��#��T����S��!f��N�;��\"萭����,�\Z�J*�*J���{W>\0�7���C`�ET��f��n���i#\0�Q./��@?X�4�T�U��;9:�)@�sT��\0�~��1\r��T�U��;�-�:)\09�@?t����\n���q� G\09�Н\Z���0+\Zn\0� G\0y,*\Z�2*̊�\09�@^�\0���{/fE�\r�� /`�EEý�\n���@�\0r�0�����M�Y�p G\09�`��O�����l�vQaR_}U�Ϝ5.��� /`�E���|(?���RaR��?��9kv�\'\0� G\0y,�]u�e��̙J�F5v�Ui�I$O\0�@�\0�X0����˵�f7<�=zT��&�< G\09�`���&%=H�5f�UK�Y�K�\0�#����0��3O�/*ZA�ۅ���t�9/�u1y@�\0r�0��G�9��w��k�{��Qc·1�	\09�@^�\0�¦����l޼�>�;ݡ�ζ���n�l���@�\0�t�6�g���~����L�e��M/lh(�1������䧿�h����;��\'\0� G\0y�{�Ԭ9fm5��z��)����m��8��� /`�!�eY�/y�\0r�0��9d+�˚W	��	 G\0�@^�\0C��4�﮽���<�\09�`�!���v��e!O\09@�\0�:&�h~P2���w��@�\0�#����v�uۮq�<�	 G\0�@^�\0C�d�z����<�\09�`^K[��.7y�\0r�0��NY�4���<�\09�``^1�\0�#��00��<�@�\0�0��W`�\09�``^1�\0�#��00��<�@�\0�0��W`�\09�``^1�\0�#��00��<�@�\0�0��W`� G\0�``^1�\0�#��00��<�@�\0�0��W`� G\0�``^1�\0�#��00��<�@�\0�0��W`� G\0�``^1�\0r��00��<�@�\0�0��W`� G\0�N�,k@�T;y�X�y�#����\\�4�cx�X�y�#��^v�v�Y�x�X�y�#��ސ\Z�q�<,�<�@�\0�����r�w�ٺ��\0�#�� /@��.7��fa\0�@�\0r��d\Zl�fa\0�@�\0r����y4�	�,�<�@�\0�t���l�fa\0�@�\0r��\ra��0\0� G\09�\"g�)�;%%e�ĉ����6���;��pQ-TϞ=�;���?>|�F��HF�@�\0�#��tc˖-�g�ȑ�111jΜ�*??O54|e���QA��nEE�*1�95p�������5_�Y�y�#\0� /�Lj�+���맒�^P.W��46Q�X�ɋT�>}�:��Soba\0�@�\0�#��t�f��.PEE����[�Uyy��۷�?�����,�G\09@�\0�ҽ,[��ٲ]T��l\n]^�t�Kj̘5j�����Q7ďTɋ��MG������SN9����^�y�#\0� /�h�(�{��kꓒ�7O~�U+�/U�>J�z�X]c�ܨ��UC�^�������8��^�z�0\0� G\0�@^�TJ�11?R.W��6zU¨x�h�p�H�~�����aW�Mwl�������Ԝq,�<�\0r��(4qℽs�<i6�_7����櫬�2TʋIz��U#���������Qm�i���i΂D`�\09�K��Ґ��c6�\r���\'���Tm��������T�>s����C�?S\'�o�������ջ��0g�N`�\09�K�ݻ�jh��l\0��c�R�E[Ԏ�j��]rzǎ����{��%��9\\�d�%X�R� G\0�@^��R��f�r�]͚5SM��$URR���ۣk׮j�}��f<x������ޖj{u��ě%GeO���!v,�r�䥛4�u^����Z��5�SU�Q�zp�}^UZZ��\\~�z}u�jh������W7H�O�-[�?��f�\r�#\0� /ݤ���S�}wL��!]\r\Z�j���{e�U��*��?���W��W^2��4�{��W^���W�o����>��W�ķ�n�r���\0r��hk��9�u�&�[��d��mVof��F{��%��ŋT�Ϫg�=��������kF��o�����Ih�����;�,�r�Q��f�g�Z��ͪ��p�Y���i�Lk�(n����c�~��D.����ź�����-P�\'�S�;�I���Q3g�V=�ģf���~7�~����^Q����f�-�,�r�Q��qf�ZM�+f�f� �N����1V#�dM�oք�l��pJ\Zn�	��o�Y����n���~v�5w��g��[��1��朷�����o(�Fp[�����\0� G\0�4/�Dg�Un5ӽ���4��[ͺ �\Z�N�ݻM=�������Zv%�WqqCԯ\'��[�KK�����eo(��b-����f�\r�#\0��ܼ�7���E�W��>�~�ek���}�U�o�����S����*a�uj��+�СW��+���f�}�����ߣ�������T�+��P:�{8�����\0rDh^d%^���I�w�u����>BuQE�JkH����� /!2�j�c:�~c����-�f���Eo(�}�q�t���#\0����HS,�ǝ���Ժ�A��p���\"�\r���g�3�N�o0|oǁ�X��@�\0D@^�H�3O�c�w��Fv��7��*��P|�DK������t�M7+8\09��0΋�����wk�������!��*B�P���}���� �n�fۮ���nVp\0r�#\0a�����K�[���� �E�o(��`�sKM���S�L�w�Y��@�\0�Y^���\n�cV�`��~�0�m\r������ֱ��N����t����m�ٽ���@�E�W�8ď�h�����+���k���k�J�#3s�s:\'\'M�����6���={6����^��yޮ}�v��O>�M�c����]�f���gg�Vg�yF��甔y��څ��hO��Z�l�����l�f G\09��yYk�m!~Li�°�+��U�l�j���={���9f3\\��?1�q�4��8���Z��ަ��V:�e��U�1�0�}Z.��-�eZ�\'םrJ���С=z��Y�g������^4���U]����;V��~+*�TMM����[�&O��3}qq����p��lҤ_��8qq?է�6lX��;�ܠ_�.n�[��v[��@Mw�v6�6���\n@�\0r �\"�w_�ǌ1��0n�=�j��n�?mw��g̘�ޫ�8�K���������#}^\Zr�i��Z�Ǝ�AM��f����z��z���?��WJ���_��ǲo3q�mzZ�����ii�׫k����{�y��x���ȑ�԰aC�����~ކ�Z����X�^�f�s��]nk����{���m�^�0�i�[j��:�lw����� /��ά�C���x\r�p{nՌs7������5����Ym6�s�i��j6��F�;Ʃ�ҍ��i�3���2m]]�JOOQ��.|Z_.��_����]x�Ul���<���שI�n7�j��yz�4��er�ii��m���e�����,�l��O���^�<gy�r���Z����z�.�n���隚m��o��f\r�����eMwG�mߦ��t���#���TEb)��v�ܶ�*_��7�!���k��C_/�=�MJzB�]W��JN��/�:����Y����=���u����_����4�YY��������?{��\'��[�o�}�ڲe���~W��С]�s��X��?��-R��[[���ٯ��h�k���L�n�[����;\"ɺ�>,cY��@�\0�Zl��@�4�[,�#���߾����R]~�Ŏv���;�I�.+��4�g�u�:��&Xn#�_r�`UP�G��~Z���[�W�zA_�o�v��8۶�S�\'�W������R�8˗\'�i]���=7������2���**r�����2���D�Ǐ�&#�e��#F\\������lݾ��QA���}���h���iiw[~�;�p���#��¼��֛)�x��I�U\\�i6�K�}�^���@UW8����]�L/�/���+ԁ;Tzz�n�kj��;��popn����s��ctC������&M��l�����e�3N�f߾m���}T�U*//�j��9�m���Wzݷ�?��o��ii����u��;�ذ��:��|��=M7��f G\09��y�(�Ǜ�\"�����l��/読-T˗?�c����f;_�{���zws��3��ON~J9��lj��\r�\"}Ycc�utr���o�}��\rw��K����яa��q^�lZ��kj\n��å��몪�q�������6���Ч��=K͘1�]�c7ܭ�\r�&��[��������ts�rVp\0r�#\0a�~��孖>\rwM�e��jZMj�JIq����ڹ��p�~�0��e*#�%������ܾN�C�fe����7���.�G֮໛=/�ǵ/�w����[[��X�ߦ��\\.����m�����=���������t����;ۭ�Nw C~����@X�e�Y��Pt����3H������J��Pa6�Ku�t�p�����ڙ���.�:_R�>�r��,�����75}�LSP�f6�������}P%&>b6�睊S�SM�6Q��*,\\�N;�u��^��f8��ߪk��T�����QW��u�����~.�a����[��j�<�����D�XimskͶ�Φ�ޭ}�SVp\0r�#\0ᑗ\\#t[ä!�\Z�3H��WSSUD��z�|C	�����v�M��x4۬�\0� G\0�(/��^n�f+��;!r.�}C�-ݾ�w�i�;����>��w�Y��@�\0�i^���j���V#���wr�]EuQE���O�y6�mi��Vn�O���#��ĘuЬ�t��Z�?(�g�RR]T���{�4������v��o���#��%D���Ŝ�f^�wB�� �*�.�(xC�������:X��@�\0�q^&Y�qgm�Ժ�G�a)��E%o(��twv�Vp\0r�#����l�-g��|�Z��}�j�b)UAuQE�JGwg7r�\09@���K������v���ַ\"�}��A�4��z�ꢊ�7��U�����\0rDQ^n�\Zo�-|���	��:ݺ�t�9� Ѭj�ўdD���[h�˩.�(|C	v�pv#g�\r�#\0��Ҽ0���Z�w�����fe�]�c�y)��E�o(mm���Ug}��\09@�\0��\rw�E�I������f�6@�\0�#��Dyý�ꢊ����n�,�r�䥻4�{�.�n��f�6@�\0�#��t\'�|�w\r\r�f�\nq}�U�>s���0���$�m�\09@�\0��m��C��K�p�Z�����Y����ka�O���\0r���᪫.[7g�T�,�B\\c�^�f�v���G\09@�\0�m�A��|�r��	m}ңG�\nsı0\0� G\0�@^�T��?,MJz�&8�5f�UK͗>���G\09@�\0���y�i�EE+h�CP��Kכ��A�.fa\0�@�\0�#��D��s�9��4�\'���ѣG��=���y�#\0� /ݷ�>���7���Nw�g�ڍ���}��� G\0�@^��A={~/���O=<e�-�7mz�`CC!\rs;ꫯ��[�����h����;��0\0� G\0�@^��K͚c�V�\Z�IW.��;���_q)�#� G\0y�y�� /\0X�y�#��\00�\0r��\0�\0r�#��\0`a\0�@�\0r�\0,�<�\0r�\0,�G\0�@�\0����G\09�@^\0�0\0� G\0�@^\0�0` G\09�\0`� G\0y��\0�#� G\0y�y�� /\0X�y�#��\00�\0r�#\0�\0�\0r�#��\0`a\0�@�\0r�\0,�<�@�\0�\0,�G\0�@�\0����G\09�@^\0�0\0� G\09@^\0�0`�\09�\0`� G\0y��\0�#��\0y�y�#\0� /\0X0�x	\0r�#��\0`a\0�@�\0r�\0`a�<�\0r�\0,�G\0�@�\0����G\09�@^\0�0\0� G\0�@^\0�[���j\'/l� G\0y�!f�Zi���2���\0r�\0��n��.2�/l� G\0y�!-4��xyX`�\09�����]n��6[�Y`�\09����]n��� G\0�@^\0t�L���,�r��@���h�x9X`�\09���c����,�r��@\'\Z�6@�\0�#��\0�*�z���̜8q����؆޽{��-*��ٳ�w��gÇ�h���Q��#rD��9\"/@7�lٲ{F�Y��̙����TC�W��;��%�cQQ�JL|N\r8����{͗�bVp�E��9\"G��#�D���W����O%%��\\�Fsa�D��JN^�����թ��z+8�\"G��#rD��y�x�|������B�[*DU^^������{�~�\"G9\"G��#rD��Э,[�����h���py�ҥ/�1cԨQ׫믿F�?R%/Jj6��*/߫N9�/��ߝO�#rD��9\"G��#�tr ��#��OJz�<��W�X�T���(u�-cu�s����V\rz�Z���P�T���?�իW+8�\"G��#rD��y�DJ�11?R.W���h���Q�z�|�\r#���ϮSÇ]i.�c�MOu��>��O�Y�\n9��9\"G��#rD^�(0qℽs�<i.�nV#�ǩ�WYoe����\'�W��/��.ח~oG���M�w�9KY�!G9\"G��#rD��bc�4�����fu�����~��nyGe�i�Z�j�Z��F}\\������շ�~��vT���ws��d\'+8�\"G��#rD��y�@�޽UC��悡�Y=6�!U\\�E�(ުv�*�%�w�خ{�!����_2�Y�b�Q��#rD��9\"/@���(�e�r���f͚���f�*))T���ѵk�5���V3�O}���~oK���|���9\"G��#rD��y�Y�]�U����u�^S��?U�U����U���j�嗪�W����Ϛݞj��C�(rD��9\"G�� ���p��6��aCcUMu�z�l��ݼQe��G���J���K�B;M�t啗�����o�����\n9��9\"G��#rD^��Z0sj�M�7ea���Y�����+�/Q//^��^xV=3�i}���/-T�^3Bm|{��}P�/Vp�E��9\"G��#�DՂ��N=6�w����\0^��Xג��U����y��>����#j�ߪ\'�x�\\(g��ͼ��>��+8�\"G��#rD��y�j���S�`��������i���,���?G͝�z�ٹz�,�1��朷��T\'+8�\"G��#rD��y�j�|ԩ�{��G��~y�8���]��U\\���	�������z���b�Q��#rD��9�\"Y�sn�v\Z\0�]0�U�o�����S����*a�uj��+�СW��+����������G;�=�����+8�\"G��#rD��Qb�;���{���&�\n9��9��9\"G�e��l�Ջ�	z��&�\n9��9��9\"G�\ri��G��k�|�\n��╀�K G9\"G��#rD���r�w�ٺ\r�o��7*L*JWp���¬$��rD�#rD��9\"G�(l��.7��ڿ`>D�IE�\nN��J�lQ�,\nڌ_rD��9\"G䈊�e\Zl�:k�|�\n�����\0[�p���#rD��9��)Gq\rw�~Ղ�\0&E+8	�����\'�#��#rD��9\"Ga��.7[���-��J�IE�\nN[W^�i���#rD��9�\"=G̺Ϭ�fU�Uo�\rf}b�w3�iM���Z*L*\nVp��R���\"G�\"G����%?��k5֪��o�Z)�M�O�0�_�i��]]���0~�9\"G��#*�rcVvM���j��T@���T�T��ttw�Hߝ��K��9\"G�Q�����H��ͳ�j�\'�u�Y}�i��5Ⱥ��n�%\\>�bk7x��*L*BWpZ; M���#rD�(rD�(r���w��t��������}�{2��w���\n�����>�k�nY`��#rD��9\"GT$�h�O�\\i��f��ܮܧ�fK7�|��I�K�߶m�����>}�����奩#��ɓ�CM�t�Wmܸ\\ee-S-=�\\7mڝm~^�W\'���;7��55������@׆\r����s�߷o���%%TYY�>-?jVr�͞����9���*�~}#h��`�{f�i�\r���\"��5����:�E���9�1�w#��_���}��湆���h�\0�����JK��A���Qze_N�{���3�<C-\\��3����<o߿�?�k��ӧ�TK�-��t�\rm~n���P]}ul��Hc �TW�����n6,����^��~o�\'ޢ�l���F�?����;~�rs_�Ӗ����/X�^.��X�.��B}�}����/���s���O�e�d�������v���C��9\na��_�QQ�#�Ƹ��mϦ�ܧ�p|�\\�j;V�t��;����̗��={���w7\n?�,=}��R��\\i�b6\n��[���\"��MM��>�:�����#��G��V����KJ2u3Q\\��.�����{��W����׿�L�r}���e2�<�Çw���g�i�����5k�UL�\0�6r�����m��ߦ�������:���#p�ư�x�NԖ�ϕ�&z\\Iߡ#G��(GTh��#*�r4�����ŝ|�޻��k9p|��q�UW��\Z0����Z�N9��z��{Un�:L�&ݪO�{n����{���^�F��JM�2�\\YN�ӟv�)fðPUW��=vS�{7Si6ZzN���ر�9�e��i�y�fz�i�zk�}�>���R���#GJ�i+*6��jk���������h��F�����w�u����ѧ+��}�ܻ��sh�����@+�VVZZ��7}���#�;t����\n]�#rDE]�<�n\'���x�`+7�o�\\�b�Օ�7�������o�Sa�\ZU^�Q�w�����-s��yy�Y������@��g�[֖�ș����\'%ӧ���9�a��*&�_��)j�������K�ٳp�+.^�o/[�<��w��l64���V�Y����=--ɹy}bc�]M�6�l2���4����Yg�i6;�m�ױ��#D�X�Ib���JN[Wn|Wr�bw���V����\n]�#rDEU�Ƿ>���\'����\'�bh�\0�`��M����:��tðj�szW҇�������_{Zw�p�>�o_��$��46V�@�-��}���V�nj����e�e�&�2ْ8b��^�ee-ѻ�N��_jҤ[t���fd���y:T�ܷ���@n#M���I�\\���������7����ȑ��X�[�_B�`�G�qm�M[W2Z[�	v����?�-m}��9\"G!�u��#*�rt��tY\'����x���Z�^0W�XlS��+Ե�ƪo�Z��;��y�TS����LΗ��ӷ����lke�Roɒ����W�[�������rz��GZ|~2���3�]v��	^�mܸT�Ծ�ꫯpNoذؙn��=�\\����[U����V9�;1�!����ܦ�~���~}������T�q23SZ�_B�`�+��OF�ݍ.�JN�v���n��JN[_+rD��Qr�9��m{�Ɇ���t2��C�ɓow> :�A�R�������nѷ�|<ɩ��(/[_�r}����8U]�Yh���!��y^2PS���\'[}m~�7�i���ٳ>�טEw��2�孜��Y�O��tɃ�3�}̾���Y��	���� e�9����%���y����S����O=�S��-[^WӦ�Z��=�Z�q��ȳ	�t����6�@�4��XMM�+�yY�-t7�t���m~i\n.����;z��\\`�h�^z�����\\�{l�l��_9竪6y4�Gv;���w?�V=�u��X��\'���z�\n�+�n?l�e�B6C_�����~>���������On�r������lY�/��yy���Zwт���\\�ii%��+7}>\'��\"G�� GR2f}��̦y�u���ԧ�G�̙��^\"�o/{V�?�\n�!{�c������̀�=��T}��d�:v�Թ����)V��/�LH�/������)S~�d�^V�ʿ�_�&ݬ��^\'qq���R6�d}����\\9�9�f���nK����Q����������s>�O��g�1�>�Ƈ�����>��=�\'L�����Z��7�ͯ�1j�7���5�y^�Ϟ�[��Aɋ��}ʰ���!]����Ӳ�\r��\'��W�o���W�^6���m{_�0�Q������3��>��􂹲MU]������m����B텤�45U8ӺWr��m��o���)��6��~��q7lH���|�����\\.�ᬳ�?���#E����^e�����y.���\nG�nt����}�����칤�=�Zu��N������i�^�&%=��oh�km���&S`�i�c�<c6U����]�`��d4�>����ӑ�ߕ��0z��9\"G!ȑ=�d{�oY	��2`��d�YƗ�)�1�z�sz\\�tr�B�{����͛�5�dѾ���>?�O�s���c��r�iY�_y��X[��%k�m%s���s���P��~�^�ع��8����jtr����ܨ���,��Q���6�g��/�̖�26导\'�u����G9/����cGz5�vfKJ�����%K�V^�#=N,x�:F�.�$W9�CƬ���>���j٢�!�m��]�[�r������:�r{����sb��ط���&c�+��}O�����X\r�Z�^0�b������S�;�m����22�9/+\n�\n�}^V��O�S7�%��W�e�Ç�镆�´��A�s�|���z��SO��l��ҵ�\'�����oP۶��[�,x��={�t�X<�����Rsee�����w���^��ۗK54�\rD�>���L�5�wO��\Z�Ն�f�+��㫇�-	U���n�9\"G����H�р�d�Կd��=F���4Ş�q��\Z5j����q��z��>�܏d���7������9\r��!?T_����O�_y�C��6��<\Zˬ�g<�p\'�-𞙐9R�˽5o�>-9����e\Z��|�f/+���ݤ����~�R���\0��yE���^��c�J�=w�1F�?45��l�ȴ�Qϲ����-�k�f���62��v�����RS��Ǫ����Iv��&�����ͼ}{�~�GN{��~��R��lL���7�/~�y���<�}������~< �����]��Z�.�$t�����5]kG������.j8oQ�}��9\"G\'8Guu;�ߍ��Z\Z�}�r���͕����x��x��>������\n��ݫ|777�j�+Z��\n�t�sؿ�k��G�i��2�-v+�cef��:/_>�l8�\Z��V����Ho�4��k<K�a?W�9������o�K�c?vi�\Z���.L�x?jӼ���h��g\\�������II��d,\'\'?f}�i��]�)z7u{z{��l��dڳ���j=��s�p����L�m�C�a�.�z�����󹺛��˔������z�^��������3�y�~?�c7Х\r��T�T-�}߬}W&�����t�w��V�_rD�B���֑̅�_R�V=c���P?|�>�>��Kδg�y��$_�O�۷�i��i\Z�(����}��\n���c��뮛��>��^�=Zh�6[l����-��}ڕ���\\y�o6>��w7�������m�^k6��?u���ɷ����_�LW\\��&L�4#��o����9\"G���T]~��9cMƿ�.+{�K���9眭����3NdO-s�ɳ��S�G_��i�ݲ7;e����֖�uVS��߱g�[;c�yi���fO�z�|���Ը�Pˇ\0˗��_SZ��I�q[z<C�R��ܯ��ƕ\r�G|��چ�<�����s��nG�ӯY��9�ظ�:�ҫ��.%�V��*����Y�%�K�Ef��bӑO��Ԋ�����ӕG�m����1���XgBN=�=�t����bN<���<����2�JԆ\r������UFF�3���^�n�q�����g�Ӿ�\r�ܑ��̑�ai���)��Νfm��_M�r��,����oc7ܕ�oY�-3���><ǝ���־�W�����ͼ�3����[��������\'�+��j֬�8�%+�G�l5����Ƨܷ�?r��=v�H_�;��(�h����*��=�˵�Yn�����s���~䯊�_w>�1,�rWWo���kL��d����\'cW� M����{k8���\'�\r�X�������I�n�e���\r\r�����\nW�ol۶�j��[�|���`���[�7��r���9c_��w����s��F�Ο?�����hy?�(�@�6�JJ��&y�Z�`��}���J���|s%~����d-����\\����>�r��Hț����f.�S��v��t3.���i)Y`�w9��oY�+��M�лC��9-ׅ��	т��-�$���5m�wQbt�����_U�e5�/;㡴4��t��;��˸����*-�Y�\"#Y���[�\n��$&>�?���O�e2�)��s�-���o���?ֹ#Gљ����z�o��7�֑�G:��-i�%��o�\r�6�Q��u��I����]��q��Y�?�A���t7\r�f�����~L{zόUTd���1(�m��G�l��#�s�ǲ�*���H��;�%��t�\'ߢO���G͘q���r�\\��O��k�]e߱v�\"G�����?��1C�L�z���[>ܲǅ��w��ȑ-zN��2;[r{C�u��lj78�p�W?��س�Θ</{QƱ�������G���l�߳��Iɠ����ڙ�S�F����\rtm�]�:|�@��76��rҟc}j��^��+���~G��k�LŃ~����~�s�}D��Ӻ��:E�nh(QYY��6s��g���������Դ\'$����h���Vn�v��ػ��������9/[�������m��/ԧ��.,\\e�Hqn�^��u���^+��I�;�\'�՗ٗK�`�FV�d�Ai:�oyx�Z�ʲ�l��#Gѝ#�x�1{��>\"��sܸ�p_�?t��y�}�~��G�nu��é�o�Y�qe?����uw[�$yq7ǧu7�e�����޲eE��]��ƶ�����Ƿjɸ��s�2��6���w�#ޏ�w{l�x��C��ǹ^Ɨ���j�2�SS����fF������(�_w��s]��3���L��eek�_�Hu��l�1���~�;�ƨ�.�u����{��r�����\Z�L\'��л��\Z��G�rY��e�?���m��{���{CZ�¬�2��t��d[[����f��y�b�wC�s!�N7�vs�r�}���mݠ���c��:/�!o�����6a>^mYh��M�+9�㍋��;i7��|Ĉ˼.��v��̕�_蕓ŋ�[�g̘�\\f�-=��GY�\ZsE�sf������Y�b=��i��9�![4|W��i��-��p�9����n�ͳ�C(�e2�/��_���>a�_��ek���t6<Kn�a���Ǖ��i�~�)w~���d���q���_�+u�՗7{_��H 9�i$��(��\r�D��.	8���S�Fr�����9?~ݨQ��c�%_������,���^���W�ƅ�{������i�k��~c�_��,�͂3���^q�kN�|�+�\'r?��ؙV��r�i�=s\"������+Dꩧ�q޿쪨x�y��p�C��(x?���\'�1��x���Y��`����ۮ�DL�6^/e��oߟTj�z!w�H���k��^��z��z\ZC�f��^IZ��q��8]_����Z��y��hl,�>�}A�����a?��\\�����Ȋ�l-,.^e��,��c?�3�e�ww�;�����J�� �`DM�rs_6W���۪Usu�;cƯ͕e��`i�l�d��l�iu7���2�%��e�r��a��?�*/_�l�WU�w�}YI�����D��ڽ`OX�u�55�\n�2��+��/9��G�������,G�<Ʒl��샧]lߊ.5�6p̻CV.�Ns��s���us!Wj�~���L�[����u;�\'�����FkW����nd��E���n֧�I���^Ӯ^=�����1xQ߿}{����14��9�W��-�++mY�1Z�](j�KsTW�M�{���\rI���QU�i6�;������y����FX�5]m�&�_���7������z��x����<>�L�E�n˖ea�;r��rD�~D��9j�|����輟��+7��n�2\0��]!��z�o#�x�p�)x�j&޴v�K��o\"�����x�9=u�m�������\"}Z�}D���._���}o޼�����\"��<������rrC��D�\n��J�����F�?��{����jD����m�}��n��@�p��؋ԤIc�8�1{����&��o[߁]�wCN�J��/��_������s�2���#t�~��6w�Q��#��c��\n�l�;�tK������`-�`.\rY56y4��ֵuցd^q�𼼗�nw��.UG��<s�)\'�\rɖf�a�#�ƚ+��-m��i�]\'8����I�\\;�Ͼ�455��ϖ�����!Z��\'�Vp���tƖ��8�kX��ȑw�,��mۖY�������4�,��^-jv��V�V+W>�����\n\n��\r��A�LUWg6�y��o��=�K��Q����9b�����vy��-[�ۻ{���s�6��]�`nhp�\\��j���\n�{�[�nrr^�������q�f$#�9\'�l\n����ima8a�ϝ�\'GT���x�:���`%��W�\"*Gv6��穦�}��`ذoq�H��{YVVR�i���z^��h;;�;C�Ν��1,��uC�&���4��2w�������#r�&�|�n9-R�����t��܇�#�V@�4ܲUK�{n���m����M�������������o\Zy�����Eo}��\"�-���co	��nw���^�娴�5��j{���Y��r>�ji�ػ��w�^h횝�wz��JK��#��$2��6)�A�\0kl�8��ܑ��#��#rD��QP�[c]�4�YVC.[����e��A�m�0ܻ�{ޮκ\r��`��vt\Z�A���E �H69\n��N�#G�\"G�\"Gmcx��=���;�\0f�!�nx���9\"G��#rD��h��mV��\n�ўdp4r�3�]�b�wA\ZG�(rD��9\"G�u�f=`�Z�>1����阮{w�{�8\0�,��P�������E��\r9\"G��#rD��h�\0�,�#h�B��G��9\"G��#��\0f�a���+7��#rD��9�h��`f�ܥ+9IQ�rC��9\"G��#��\0f�]&����E��9\"G��#\04���ՇQ��#rD��9@�M�`9\"G G��\"G\0X0�`9��9���9���b�L�(rrD�@��\0�f�#rrD�@�(r�3f�#rD��E��E�\0�`�X0�#���#�#r�3ł���#�#�`�̂��Q�Q�\0f�39������.\'�|�w\r\r�,à��j�>s����\"G�\"G G�@<�Ǉ��`�Z�����Y��QI�(rD�(rrD�\0D����lݜ9SY0�A�{U�9K��\"G�\"G G�@0����˵��c��\'=z��0gI��Q�1���9%���aiR҃,��ƌ�j�9+r��\"G��#�#r �:���ꋊV�����_�ޜͺ��H�(rD��99\"G\0�O�9��wΡ_(��ѣ�|��0�E�@���9��N���y����������X�d�L�(rrD�@����aPϞ��9��SO�r��M�^<��9v��1�OD�Q+�i�w{�݈Q����#\0�̥f�1k�Y\rf)���2ܿ�(?�Q+�E�@���9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����9���6BX\0\0\0\0IEND�B`�',0);

/*Table structure for table `act_ge_property` */

DROP TABLE IF EXISTS `act_ge_property`;

CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_property` */

insert  into `act_ge_property`(`NAME_`,`VALUE_`,`REV_`) values ('next.dbid','1',1),('schema.history','create(5.15.1)',1),('schema.version','5.15.1',1);

/*Table structure for table `act_hi_actinst` */

DROP TABLE IF EXISTS `act_hi_actinst`;

CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_actinst` */

/*Table structure for table `act_hi_attachment` */

DROP TABLE IF EXISTS `act_hi_attachment`;

CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_attachment` */

/*Table structure for table `act_hi_comment` */

DROP TABLE IF EXISTS `act_hi_comment`;

CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_comment` */

/*Table structure for table `act_hi_detail` */

DROP TABLE IF EXISTS `act_hi_detail`;

CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_detail` */

/*Table structure for table `act_hi_identitylink` */

DROP TABLE IF EXISTS `act_hi_identitylink`;

CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_identitylink` */

/*Table structure for table `act_hi_procinst` */

DROP TABLE IF EXISTS `act_hi_procinst`;

CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_procinst` */

/*Table structure for table `act_hi_taskinst` */

DROP TABLE IF EXISTS `act_hi_taskinst`;

CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `CLAIM_TIME_` datetime DEFAULT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_taskinst` */

/*Table structure for table `act_hi_varinst` */

DROP TABLE IF EXISTS `act_hi_varinst`;

CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_varinst` */

/*Table structure for table `act_id_group` */

DROP TABLE IF EXISTS `act_id_group`;

CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_group` */

/*Table structure for table `act_id_info` */

DROP TABLE IF EXISTS `act_id_info`;

CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_info` */

/*Table structure for table `act_id_membership` */

DROP TABLE IF EXISTS `act_id_membership`;

CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_membership` */

/*Table structure for table `act_id_user` */

DROP TABLE IF EXISTS `act_id_user`;

CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_user` */

/*Table structure for table `act_re_deployment` */

DROP TABLE IF EXISTS `act_re_deployment`;

CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_deployment` */

insert  into `act_re_deployment`(`ID_`,`NAME_`,`CATEGORY_`,`TENANT_ID_`,`DEPLOY_TIME_`) values ('bfbf91e71b594f758116859ae838df75','SpringAutoDeployment',NULL,'','2016-06-02 09:03:44');

/*Table structure for table `act_re_model` */

DROP TABLE IF EXISTS `act_re_model`;

CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_model` */

/*Table structure for table `act_re_procdef` */

DROP TABLE IF EXISTS `act_re_procdef`;

CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_procdef` */

insert  into `act_re_procdef`(`ID_`,`REV_`,`CATEGORY_`,`NAME_`,`KEY_`,`VERSION_`,`DEPLOYMENT_ID_`,`RESOURCE_NAME_`,`DGRM_RESOURCE_NAME_`,`DESCRIPTION_`,`HAS_START_FORM_KEY_`,`SUSPENSION_STATE_`,`TENANT_ID_`) values ('test_audit:1:d6e6b5d8555341d5b434d2b749c263d1',1,'http://www.activiti.org/test','流程审批测试流程','test_audit',1,'bfbf91e71b594f758116859ae838df75','test_audit.bpmn20.xml','test_audit.png',NULL,1,1,'');

/*Table structure for table `act_ru_event_subscr` */

DROP TABLE IF EXISTS `act_ru_event_subscr`;

CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_event_subscr` */

/*Table structure for table `act_ru_execution` */

DROP TABLE IF EXISTS `act_ru_execution`;

CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_execution` */

/*Table structure for table `act_ru_identitylink` */

DROP TABLE IF EXISTS `act_ru_identitylink`;

CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_identitylink` */

/*Table structure for table `act_ru_job` */

DROP TABLE IF EXISTS `act_ru_job`;

CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_job` */

/*Table structure for table `act_ru_task` */

DROP TABLE IF EXISTS `act_ru_task`;

CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DUE_DATE_` datetime DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_task` */

/*Table structure for table `act_ru_variable` */

DROP TABLE IF EXISTS `act_ru_variable`;

CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_variable` */

/*Table structure for table `cdboo_business` */

DROP TABLE IF EXISTS `cdboo_business`;

CREATE TABLE `cdboo_business` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) DEFAULT NULL COMMENT '所有父级编号',
  `name` varchar(1000) DEFAULT NULL COMMENT '名称',
  `hierarchy` int(10) DEFAULT NULL COMMENT '所在层级',
  `sort` int(10) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(100) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_business` */

insert  into `cdboo_business`(`id`,`parent_id`,`parent_ids`,`name`,`hierarchy`,`sort`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`) values ('0f49a373b96d491db33d244b30a6c485','7ca46f70b70e43a780f4b12706df8aa6','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,7ca46f70b70e43a780f4b12706df8aa6,','1',1,30,'1','2017-01-08 10:11:49','1','2017-01-08 10:11:49','1','0',1),('36af0899b0b64135adf7d152773a9941','0','0,','餐饮行业',1,30,'1','2016-12-02 10:41:41','1','2016-12-26 17:21:40','餐饮行业测试模板','1',1),('3ac0ef1e929946bc88d1fdfa1469af3d','aa61d6bdf5b64183bc29d3fbea499f15','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,','天津肯德基',3,60,'1','2016-12-26 16:51:36','1','2016-12-26 17:22:13','','1',2),('42a6b4ce39034b04937d527cf47b81b8','5ad1eb4b845b4b7c8040328a4c27446c','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,7ca46f70b70e43a780f4b12706df8aa6,0f49a373b96d491db33d244b30a6c485,5ad1eb4b845b4b7c8040328a4c27446c,','1',1,30,'1','2017-01-09 09:39:33','1','2017-01-09 09:39:33','1','0',NULL),('4b8f0a19f6044ea6afa7e517cef91552','650296c6eff74a08a8b657a7e94e8433','0,95c241c972b142649bbd22745e7d7068,650296c6eff74a08a8b657a7e94e8433,','1',1,30,'1','2017-01-09 09:36:21','1','2017-01-09 09:36:21','1','0',NULL),('5ad1eb4b845b4b7c8040328a4c27446c','0f49a373b96d491db33d244b30a6c485','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,7ca46f70b70e43a780f4b12706df8aa6,0f49a373b96d491db33d244b30a6c485,','33333',3,30,'1','2017-01-09 09:38:07','1','2017-01-09 09:38:07','3','0',NULL),('650296c6eff74a08a8b657a7e94e8433','95c241c972b142649bbd22745e7d7068','0,95c241c972b142649bbd22745e7d7068,','测试',3,30,'1','2017-01-08 10:14:08','1','2017-01-08 10:14:08','3','0',3),('7ca46f70b70e43a780f4b12706df8aa6','aa61d6bdf5b64183bc29d3fbea499f15','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,','北京肯德基',3,30,'1','2016-12-02 10:42:35','1','2016-12-26 16:51:03','3','0',3),('95c241c972b142649bbd22745e7d7068','0','0,','服装行业',0,30,'1','2016-12-26 17:18:58','1','2016-12-26 17:18:58','测试服装业','0',1),('993db76581a84b7ba4a4f9138dadb4d1','0f49a373b96d491db33d244b30a6c485','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,7ca46f70b70e43a780f4b12706df8aa6,0f49a373b96d491db33d244b30a6c485,','测试',2,30,'1','2017-01-08 10:12:02','1','2017-01-08 10:12:02','2','1',2),('aa61d6bdf5b64183bc29d3fbea499f15','36af0899b0b64135adf7d152773a9941','0,36af0899b0b64135adf7d152773a9941,','肯德基集团',1,30,'1','2016-12-02 10:42:00','1','2016-12-26 16:50:36','1','1',1),('b18a16c32a8446e3afe50a8789238159','0','0,','酒店行业',0,30,'1','2016-12-26 16:49:56','1','2016-12-26 16:49:56','测试酒店行业模板','0',3),('b8e1e8d4607241f98c82c93c4e673ead','650296c6eff74a08a8b657a7e94e8433','0,95c241c972b142649bbd22745e7d7068,650296c6eff74a08a8b657a7e94e8433,','1',1,30,'1','2017-01-08 10:14:16','1','2017-01-08 10:14:16','1','1',1),('c336c68038954abb99852eb3cfd29f67','0','0,','美容行业',0,30,'1','2016-12-26 16:49:17','1','2016-12-26 16:49:17','测试美容行业','1',2),('df0da91cf5964d7a8a79b531ee9e718e','3ac0ef1e929946bc88d1fdfa1469af3d','0,36af0899b0b64135adf7d152773a9941,aa61d6bdf5b64183bc29d3fbea499f15,3ac0ef1e929946bc88d1fdfa1469af3d,','天津站店',2,30,'1','2016-12-26 16:52:15','1','2016-12-26 17:22:02','天津站肯德基','1',1);

/*Table structure for table `cdboo_business_timestep` */

DROP TABLE IF EXISTS `cdboo_business_timestep`;

CREATE TABLE `cdboo_business_timestep` (
  `id` varchar(50) NOT NULL COMMENT 'id',
  `business_id` varchar(50) DEFAULT NULL COMMENT '只有最后一级的能添加',
  `timestep_id` varchar(50) DEFAULT NULL COMMENT '时段id',
  `channel_id` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '行业模板名称',
  `music_style` varchar(255) DEFAULT NULL,
  `week` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `sort` int(10) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(100) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注信息',
  `del_flag` int(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_business_timestep` */

/*Table structure for table `cdboo_child_channel` */

DROP TABLE IF EXISTS `cdboo_child_channel`;

CREATE TABLE `cdboo_child_channel` (
  `id` varchar(64) NOT NULL COMMENT 'id',
  `channel_no` varchar(100) DEFAULT NULL COMMENT '子频道编号',
  `channel_name` varchar(200) DEFAULT NULL COMMENT '子频道名称',
  `photo_path` varchar(2000) DEFAULT NULL COMMENT '频道图片',
  `theme_type` char(100) DEFAULT NULL COMMENT '插播、主题、节日、风格（主题的类型festival都是空）',
  `theme_concrete_type` char(2) DEFAULT NULL COMMENT '节日（新年、春节、情人节、愚人节、劳动节、母亲节、儿童节、父亲节）主题（春天、夏天、秋天、冬天、晴天）其他类型是空的',
  `channel_version` varchar(100) DEFAULT NULL COMMENT '子频道版本',
  `music_style` varchar(100) DEFAULT NULL COMMENT '音乐风格',
  `site` varchar(100) DEFAULT NULL COMMENT '场所',
  `speed` varchar(100) DEFAULT NULL COMMENT '速度',
  `voice` varchar(100) DEFAULT NULL COMMENT '人声',
  `element` varchar(100) DEFAULT NULL COMMENT '元素',
  `emotion` varchar(100) DEFAULT NULL COMMENT '情绪',
  `instrument` varchar(100) DEFAULT NULL COMMENT '乐器',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  `channel_type` char(1) DEFAULT NULL COMMENT '频道类型（子频道或者组合频道）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_child_channel` */

insert  into `cdboo_child_channel`(`id`,`channel_no`,`channel_name`,`photo_path`,`theme_type`,`theme_concrete_type`,`channel_version`,`music_style`,`site`,`speed`,`voice`,`element`,`emotion`,`instrument`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`,`channel_type`) values ('2ec571af73a145e4a59189cae69f0ae7','2','晨梦初醒','/cdboo/userfiles/1/images/images/2017/01/8442159_182826708000_2.jpg','0','1','1.0','15','1','2','3','10','15','10,11','1','2017-01-15 20:53:32','1','2017-01-15 21:48:25','','0',NULL,'0'),('3acf9064949149168cdc8b705fbef2b0','3','早安问候','/cdboo/userfiles/1/images/images/2017/01/13559303_233732580000_2.jpg','2','1','1.0','21,22','0','0','3','12,18','16,21','13,16','1','2017-01-15 20:54:19','1','2017-01-15 21:48:15','','0',NULL,'0'),('78a09e4c8e1c4db680fda92a0bfb391a','1','流光轻舞','/cdboo/userfiles/1/images/images/2017/01/6062547_081856296000_2.jpg','0','0','1.0','15,16','0','1','0','12,13','17,22','10,16','1','2017-01-15 20:51:37','1','2017-01-15 21:48:36','','0',NULL,'0'),('e745c6fd278d4ed1bd888a578f7f8ac8','1','梦醒时分','/cdboo/userfiles/1/images/images/2017/01/300218769736132194086202411_950.jpg',NULL,NULL,'1.0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','2017-01-15 20:56:27','1','2017-01-15 21:49:37','','0',NULL,'1'),('e85e8494219b43269219af432babae90','4','正午时光','/cdboo/userfiles/1/images/images/2017/01/5063545_000227976000_2.jpg','2','3','1.0','15','1','1','1','10','15','10','1','2017-01-15 20:55:34','1','2017-01-15 21:48:03','','0',NULL,'0');

/*Table structure for table `cdboo_group_child` */

DROP TABLE IF EXISTS `cdboo_group_child`;

CREATE TABLE `cdboo_group_child` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `group_channel_id` varchar(32) DEFAULT NULL COMMENT '组合频道id',
  `child_channel_id` varchar(32) DEFAULT NULL COMMENT '子频道id',
  `create_by` varchar(100) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注信息',
  `del_flag` int(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_group_child` */

insert  into `cdboo_group_child`(`id`,`group_channel_id`,`child_channel_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`) values ('f2d8c74324794013865c1c64acd83818','e745c6fd278d4ed1bd888a578f7f8ac8','3acf9064949149168cdc8b705fbef2b0','1','2017-01-15 20:56:28','1','2017-01-15 20:56:28',NULL,0,NULL);

/*Table structure for table `cdboo_music` */

DROP TABLE IF EXISTS `cdboo_music`;

CREATE TABLE `cdboo_music` (
  `id` varchar(64) NOT NULL COMMENT 'id',
  `music_no` varchar(100) DEFAULT NULL COMMENT '音乐编号',
  `music_owner` char(1) DEFAULT NULL COMMENT '音乐拥有者类型',
  `music_name` varchar(100) DEFAULT NULL COMMENT '音乐名称',
  `actor` varchar(100) DEFAULT NULL COMMENT '艺人',
  `special` varchar(100) DEFAULT NULL COMMENT '专辑',
  `volume` varchar(10) DEFAULT NULL COMMENT '音量',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` char(1) DEFAULT NULL COMMENT '状态位显示',
  `path` varchar(2000) DEFAULT NULL COMMENT '音乐路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_music` */

insert  into `cdboo_music`(`id`,`music_no`,`music_owner`,`music_name`,`actor`,`special`,`volume`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`,`path`) values ('03bc400c364e432180f7b494510e14a0',NULL,'0','I\'m Yours','Jason Mraz','I\'m Yours','10','1','2017-01-15 20:40:31','1','2017-01-15 20:40:31',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Jason Mraz - I\'m Yours.mp3'),('0864b1c9b74748e9b5619a3158cccf7f',NULL,'0','Hope','Jack Johnson','Sleep Through The Static','10','1','2017-01-15 20:40:31','1','2017-01-15 20:40:31',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Jack Johnson - Hope.mp3'),('09c59f3d9ccf4f06afee86749397d977',NULL,'0','(The Man with The) Green Thumb','Tommy Emmanuel','Endless Road','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - (The Man with The) Green Thumb.mp3'),('0c8c0171c1474e86ad735f18fb2840b6',NULL,'0','I Do','Colbie Caillat','All Of You','10','1','2017-01-15 20:40:46','1','2017-01-15 20:40:46',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Colbie Caillat - I Do.mp3'),('0d01d036cdfb49f9a60121f973a7c026',NULL,'0','Everything I Am Is Yours','Villagers','Darling Arithmetic','10','1','2017-01-15 20:41:06','1','2017-01-15 20:41:06',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Villagers - Everything I Am Is Yours.mp3'),('0fc5f36375ed4d79854e339f73ce4ee6',NULL,'0','Drivetime','Tommy Emmanuel','only','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - Drivetime.mp3'),('10fe26a955a3402a8a58dd0ec1a4dc72',NULL,'0','Get Lucky','Daft Punk','Random Access Memories','10','1','2017-01-15 20:41:40','1','2017-01-15 20:41:40',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Daft Punk - Get Lucky.mp3'),('2338fa9234d1451280081e43a9b11986',NULL,'0','Endless Road','Tommy Emmanuel','The Guitar Mastery of Tommy Emmanuel','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - Endless Road.mp3'),('24aafa99cfe448ca9d5054e4e489a06a',NULL,'0','The Show','Lenka','The Show','10','1','2017-01-15 20:40:47','1','2017-01-15 20:40:47',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Lenka - The Show.mp3'),('30d2930648654a98acef91945254459f',NULL,'0','Blurred Lines','Robin Thicke','Blurred Lines (Deluxe Edition)','10','1','2017-01-15 20:41:40','1','2017-01-15 20:41:40',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Robin Thicke - Blurred Lines.mp3'),('38ec32b07bd2453ca36874d842e5c910',NULL,'0','Cowboy\'s Dream','Tommy Emmanuel','The Guitar Mastery of Tommy Emmanuel','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - Cowboy\'s Dream.mp3'),('392930de43cf46c6b98ec3cabf8d9755',NULL,'0','Can\'t Feel My Face','The Weeknd','Can’t Feel My Face','10','1','2017-01-15 20:41:40','1','2017-01-15 20:41:40',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/The Weeknd - Can\'t Feel My Face.mp3'),('3f47d4cae93b402d9522f214742f8afa',NULL,'0','Sweet Ride','Rob Simonsen','The Way, Way Back (Original Motion Picture Score)','10','1','2017-01-15 20:41:50','1','2017-01-15 20:41:50',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Rob Simonsen - Sweet Ride.mp3'),('4157885711ec4764a91a74be5754ff9b',NULL,'0','Cell Cycle','Ryan Teague','Field Drawings','10','1','2017-01-15 20:41:50','1','2017-01-15 20:41:50',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Ryan Teague - Cell Cycle.mp3'),('4571b4b202af423eb17b65c88e8756c8',NULL,'0','Dawning On Me','Villagers','Darling Arithmetic','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Villagers - Dawning On Me.mp3'),('57711e419e3b45dba5b5d2f25af13a09',NULL,'0','A Laugh And A Smile','X-Ray Dog','Pet Shop(Pop Comedy Advertising)','10','1','2017-01-15 20:41:51','1','2017-01-15 20:41:51',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/X-Ray Dog - A Laugh And A Smile.mp3'),('6666ba8e1da64dcabd9037fea7ae6805',NULL,'0','Frosty The Snowman - Album Version','Fiona Apple','The Hotel Café presents... Winter Songs','10','1','2017-01-15 20:41:20','1','2017-01-15 20:41:20',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Fiona Apple - Frosty The Snowman - Album Version.mp3'),('74a524f26cc94c63a3b76a2e7ebb9e89',NULL,'0','Chasing Time','Alan Pownall','True Love Stories','10','1','2017-01-15 20:40:31','1','2017-01-15 20:40:31',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Alan Pownall - Chasing Time.mp3'),('7fe0b5e5e1ea4488aef9ef4e3a69797b',NULL,'0','Santa Cruz','Ulli Bögershausen','Ageless Guitar Solos','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Ulli Bmgershausen - Santa Cruz.mp3'),('850246e5e7734f54998ee240b2eb9be7',NULL,'0','Uptown Funk','Mark Ronson','Uptown Special','10','1','2017-01-15 20:41:40','1','2017-01-15 20:41:40',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Mark Ronson - Uptown Funk.mp3'),('87012a7e9b104786bb31697fc403b999',NULL,'0','Santa Baby','Colbie Caillat','Christmas In The Sand','10','1','2017-01-15 20:41:20','1','2017-01-15 20:41:20',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Colbie Caillat - Santa Baby.mp3'),('8ad16a4f5f3e420ca93f03caeb9a5d12',NULL,'0','Vapour Trails','Thomas Greenberg','Something Simple','10','1','2017-01-15 20:41:51','1','2017-01-15 20:41:51',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Thomas Greenberg - Vapour Trails.mp3'),('915072710fdb48c9896cade199407586',NULL,'0','Feliz Navidad','Walk off the Earth','A Walk Off The Earth Christmas','10','1','2017-01-15 20:41:20','1','2017-01-15 20:41:20',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Walk off the Earth - Feliz Navidad.mp3'),('99cd9ac0c4b14410b23e5a39f13230f7',NULL,'0','Party Hard','Zach Gill','The 2011 Paste Christmas Sampler','10','1','2017-01-15 20:41:20','1','2017-01-15 20:41:20',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Zach Gill - Party Hard.mp3'),('9b0542df9df04e4db2f8e0763c1a63f8',NULL,'0','Heart And Soul','Lullatone','Elevator Music','10','1','2017-01-15 20:41:50','1','2017-01-15 20:41:50',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Lullatone - Heart And Soul.mp3'),('a4fae3a7f2904340a2631026b5aacd55',NULL,'0','Countrywide','Tommy Emmanuel','Little By Little','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - Countrywide.mp3'),('a658b8be5a7542109e1a29a9eebffc43',NULL,'0','Everybody','Ingrid Michaelson','Everybody','10','1','2017-01-15 20:40:47','1','2017-01-15 20:40:47',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Ingrid Michaelson - Everybody - Original.mp3'),('a7d57705fa2a42bdb0983484c64eed2c',NULL,'0','Did You Miss Me','Olly Murs','Never Been Better','10','1','2017-01-15 20:41:40','1','2017-01-15 20:41:40',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Olly Murs - Did You Miss Me.mp3'),('b6bc9bf2867d43a4b21902b98e1f64fd',NULL,'0','Half Way Home','Tommy Emmanuel','The Guitar Mastery of Tommy Emmanuel','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - Half Way Home.mp3'),('bc4857c7597941e69765af396daea425',NULL,'0','I Don\'t Think So','Priscilla Ahn','Priscilla Ahn  EP + [Bonus]','10','1','2017-01-15 20:40:47','1','2017-01-15 20:40:47',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Priscilla Ahn - I Don\'t Think So.mp3'),('be9e3da5efe74a809a33452e0ef37a56',NULL,'0','Just a Feeling','Thomas Greenberg','Something Simple','10','1','2017-01-15 20:41:50','1','2017-01-15 20:41:50',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Thomas Greenberg - Just a Feeling.mp3'),('befebd102b974357b4eb6f47b66bdf3d',NULL,'0','New Soul','Yael Naim','Yael Naim & David Donatien','10','1','2017-01-15 20:40:47','1','2017-01-15 20:40:47',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Yael Naim - New Soul.mp3'),('c9125423bf714bd59e294cc67cf0eba9',NULL,'0','Winter Wonderland','Jason Mraz','Got It Covered [Bootleg]','10','1','2017-01-15 20:41:20','1','2017-01-15 20:41:20',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Jason Mraz - Winter Wonderland.mp3'),('d83ab608cde144fd816998b68be60782',NULL,'0','here comes the sweater weather','Lullatone','Falling for Autumn - EP','10','1','2017-01-15 20:41:50','1','2017-01-15 20:41:50',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Lullatone - here comes the sweater weather.mp3'),('eaa3edf9a11f4461a793b8076d405065',NULL,'0','checking things off of a to-do list early in the morning','Lullatone','Soundtracks For Everyday Adventures','10','1','2017-01-15 20:41:50','1','2017-01-15 20:41:50',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Lullatone - checking things off of a to-do list early in the morning.mp3'),('eb64b75d3d0d42e39b71454f8f499711',NULL,'0','Whatcha Do to Me','Plug In Stereo','Plug In Stereo','10','1','2017-01-15 20:40:31','1','2017-01-15 20:40:31',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Plug In Stereo - Whatcha Do to Me.mp3'),('fc5473d084b446788c7300d64cfdfb94',NULL,'0','Haba Na Haba (Instrumental)','Tommy Emmanuel','The Guitar Mastery of Tommy Emmanuel','10','1','2017-01-15 20:41:05','1','2017-01-15 20:41:05',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Tommy Emmanuel - Haba Na Haba (Instrumental).mp3'),('fca99e8efb3d4ea6a7e8452e094a22dc',NULL,'0','Little Lies','Dave Barnes','What We Want, What We Get','10','1','2017-01-15 20:40:31','1','2017-01-15 20:40:31',NULL,'0',NULL,'/cdboo/userfiles/1/media/music/2017/1/Dave Barnes - Little Lies.mp3');

/*Table structure for table `cdboo_music_insert` */

DROP TABLE IF EXISTS `cdboo_music_insert`;

CREATE TABLE `cdboo_music_insert` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `insert_no` varchar(100) DEFAULT NULL COMMENT '插播编号',
  `insert_name` varchar(100) DEFAULT NULL COMMENT '插播名称',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `music__id` varchar(64) DEFAULT NULL COMMENT '音乐id',
  `time` time DEFAULT NULL COMMENT '时间点',
  `number` int(10) DEFAULT NULL COMMENT '循环次数',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_music_insert` */

/*Table structure for table `cdboo_owner_music` */

DROP TABLE IF EXISTS `cdboo_owner_music`;

CREATE TABLE `cdboo_owner_music` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `music_id` varchar(64) DEFAULT NULL COMMENT '音乐id',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_owner_music` */

insert  into `cdboo_owner_music`(`id`,`music_id`,`user_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`) values ('0437e00aa8e14b99a3c1c4d63443c73b','a4fae3a7f2904340a2631026b5aacd55','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('17ce114997af43a48ffab701939cea61','8ad16a4f5f3e420ca93f03caeb9a5d12','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('1f9a99c146bc4117b09d7382cc2af089','4157885711ec4764a91a74be5754ff9b','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('21457dbbcc3540bd82036353e24eb767','87012a7e9b104786bb31697fc403b999','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('232685c81b6e47f195c7ce2d0000050f','850246e5e7734f54998ee240b2eb9be7','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('25a4c95f61af466a910b0726021f492f','2338fa9234d1451280081e43a9b11986','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('375bb08664994a17b0211277f8f8eb05','99cd9ac0c4b14410b23e5a39f13230f7','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('477fbaee89cc452c84091663ae209c97','10fe26a955a3402a8a58dd0ec1a4dc72','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('478326b9a427451eb6670e4bd44b275c','d83ab608cde144fd816998b68be60782','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('4dbfe642b19b4607a4ea52f0344864a3','09c59f3d9ccf4f06afee86749397d977','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('52a36c09d1fa4cf0a9f294c297e65724','392930de43cf46c6b98ec3cabf8d9755','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('54cea7bf3c9b4f7cb01e024e37427826','6666ba8e1da64dcabd9037fea7ae6805','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('551fdda157fb421db4ca1f08285ad24c','24aafa99cfe448ca9d5054e4e489a06a','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('5c4c241323c74236bb1e423cd6e775d8','b6bc9bf2867d43a4b21902b98e1f64fd','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('6e9c7ea23795423e884475da2f97d999','fc5473d084b446788c7300d64cfdfb94','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('7a378213090141c392a4ec130b0e7505','57711e419e3b45dba5b5d2f25af13a09','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('7f4f3281e63b4436822042c920b68e00','c9125423bf714bd59e294cc67cf0eba9','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('8b8f3c7eca114f86aa35101233346733','7fe0b5e5e1ea4488aef9ef4e3a69797b','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('8d09b099ed5b478c87d51e9830e44491','915072710fdb48c9896cade199407586','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('917cd9edcd3943c4ade5e1a236ce2279','38ec32b07bd2453ca36874d842e5c910','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('91f64c18e6ba4c06bab0705248f84a17','0fc5f36375ed4d79854e339f73ce4ee6','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('a212add31b6d4403b9c730a32402374c','a658b8be5a7542109e1a29a9eebffc43','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('a658ff534e77467c80a3c7e85f85696e','be9e3da5efe74a809a33452e0ef37a56','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('b3751ca6eb854afea26e264d226813ae','30d2930648654a98acef91945254459f','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('bc19a9720c834af68055e5c480e8e1d1','0d01d036cdfb49f9a60121f973a7c026','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('d5b8af9b65c34a2d936db854e3e7917f','3f47d4cae93b402d9522f214742f8afa','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('eaf83a45c9064fb5b16b3e1ea67d21b2','9b0542df9df04e4db2f8e0763c1a63f8','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('ecb563124eec45b79c58effe10b00d18','a7d57705fa2a42bdb0983484c64eed2c','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('f438a9bb50e047b49aa759ddceb83333','eaa3edf9a11f4461a793b8076d405065','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL),('fc5a0b1ecbee4015aeacb7d69f31c493','4571b4b202af423eb17b65c88e8756c8','115e96c89a5c444e9ef0bfdefc4c4619','1','2017-01-15 21:07:11','1','2017-01-15 21:07:11',NULL,'0',NULL);

/*Table structure for table `cdboo_plan` */

DROP TABLE IF EXISTS `cdboo_plan`;

CREATE TABLE `cdboo_plan` (
  `id` varchar(64) NOT NULL COMMENT 'id',
  `plan_no` varchar(100) DEFAULT NULL COMMENT '计划编号',
  `play_name` varchar(100) DEFAULT NULL COMMENT '计划名称',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  `user_timestep_id` varchar(64) DEFAULT NULL COMMENT '用户时段id',
  `user_channel_id` varchar(64) DEFAULT NULL COMMENT '用户频道id',
  `music_style` varchar(255) DEFAULT NULL COMMENT '风格',
  `week` varchar(255) DEFAULT NULL COMMENT '日期',
  `start_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  `rate` varchar(10) DEFAULT NULL COMMENT '循环次数',
  `operation_type` varchar(64) DEFAULT NULL COMMENT '业态',
  `interval_time` varchar(10) DEFAULT NULL COMMENT '重复时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_plan` */

insert  into `cdboo_plan`(`id`,`plan_no`,`play_name`,`user_id`,`user_timestep_id`,`user_channel_id`,`music_style`,`week`,`start_date`,`end_date`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`,`rate`,`operation_type`,`interval_time`) values ('6be6f350e5ce4879828748f69f3811e7','3','c计划','115e96c89a5c444e9ef0bfdefc4c4619','a7f602677bd84bb4817e1e1b0a4cac9e','05bc0c44dbb34c78a66c68ea91731fb8','1','3','2017-01-15','2017-01-20','1','2017-01-15 21:12:44','1','2017-01-15 21:12:44','11','0',NULL,'','3c6b340568c74bf688e1020f4c161331',''),('803eec7852be42698fc2144a539294cc','4','D计划','115e96c89a5c444e9ef0bfdefc4c4619','c978305ea064427b85453c0294077a18','0251d72920a0448bbd9d13f31b272bbd','0','1,7',NULL,NULL,'1','2017-01-15 21:19:45','1','2017-01-15 21:19:45','11','0',NULL,'','3c6b340568c74bf688e1020f4c161331',''),('908177bcd6ae47b5b6adb99b7094a2a9','2','B计划','115e96c89a5c444e9ef0bfdefc4c4619','e35a17955be94e0e8608e16c06a6930a','0732f0380a07443fb22ffe5c198ba7e8','2','3,4',NULL,NULL,'1','2017-01-15 21:12:12','1','2017-01-15 21:12:12','22','0',NULL,'','35620a9b092d4a0cbd82e46a82799e86',''),('ff1c64bd66f243b3aa0ee5c3cd32a8d5','1','A计划','115e96c89a5c444e9ef0bfdefc4c4619','9bc8d46101dc4f83853881921eb922a8','0251d72920a0448bbd9d13f31b272bbd','0','1,2',NULL,NULL,'1','2017-01-15 21:12:12','1','2017-01-15 21:12:12','11','0',NULL,'','3c6b340568c74bf688e1020f4c161331','');

/*Table structure for table `cdboo_timestep` */

DROP TABLE IF EXISTS `cdboo_timestep`;

CREATE TABLE `cdboo_timestep` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `timestep_no` varchar(100) DEFAULT NULL COMMENT '时段编号',
  `timestep_name` varchar(100) DEFAULT NULL COMMENT '时段名称',
  `starttime` time DEFAULT NULL COMMENT '开始时间',
  `endtime` time DEFAULT NULL COMMENT '结束时间',
  `create_by` varchar(100) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` char(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_timestep` */

insert  into `cdboo_timestep`(`id`,`timestep_no`,`timestep_name`,`starttime`,`endtime`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`status`) values ('1b6c997d6f604d5fa794645ac84c241e','3','上午','09:00:00','11:00:00','1','2017-01-15 20:45:08','1','2017-01-15 20:45:08','','0',NULL),('2e205bcefe0e4be1bf6c265f7c803975','2','晨醒','06:00:00','09:00:00','1','2017-01-15 20:44:42','1','2017-01-15 20:44:42','','0',NULL),('81fcf4c6f72146f3b3a844eff9e9937d','6','日落','17:00:00','20:00:00','1','2017-01-15 20:46:29','1','2017-01-15 20:46:29','','0',NULL),('917ab3f5f12d4728a715ca1d5adbcdb2','5','下午','14:00:00','17:00:00','1','2017-01-15 20:46:01','1','2017-01-15 20:46:01','','0',NULL),('d81a2c6d2aec455ebc04496c4469f2ec','4','中午','11:00:00','14:00:00','1','2017-01-15 20:45:31','1','2017-01-15 20:45:31','','0',NULL),('db03069f1849485db1efbc7ee1abd743','7','晚间','20:00:00','22:00:00','1','2017-01-15 20:46:49','1','2017-01-15 20:46:49','','0',NULL),('e70ee0861f3d46c9800c91e331e7b780','1','凌晨','00:00:00','06:00:00','1','2017-01-15 20:44:07','1','2017-01-15 20:44:07','','0',NULL),('f1804438762d4f859e8d34878049e97e','8','午夜','22:00:00','00:00:00','1','2017-01-15 20:47:11','1','2017-01-15 20:47:11','','0',NULL);

/*Table structure for table `cdboo_user_channel` */

DROP TABLE IF EXISTS `cdboo_user_channel`;

CREATE TABLE `cdboo_user_channel` (
  `id` varchar(64) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  `channel_id` varchar(64) DEFAULT NULL COMMENT '频道id',
  `music_id` varchar(64) DEFAULT NULL COMMENT '音乐id',
  `create_by` varchar(64) NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_user_channel` */

insert  into `cdboo_user_channel`(`id`,`user_id`,`channel_id`,`music_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('0251d72920a0448bbd9d13f31b272bbd','115e96c89a5c444e9ef0bfdefc4c4619','2ec571af73a145e4a59189cae69f0ae7','30d2930648654a98acef91945254459f','1','2017-01-15 21:08:23','1','2017-01-15 21:08:23',NULL,'0'),('05bc0c44dbb34c78a66c68ea91731fb8','115e96c89a5c444e9ef0bfdefc4c4619','78a09e4c8e1c4db680fda92a0bfb391a','4571b4b202af423eb17b65c88e8756c8','1','2017-01-15 21:08:41','1','2017-01-15 21:08:41',NULL,'0'),('0732f0380a07443fb22ffe5c198ba7e8','115e96c89a5c444e9ef0bfdefc4c4619','3acf9064949149168cdc8b705fbef2b0','b6bc9bf2867d43a4b21902b98e1f64fd','1','2017-01-15 21:08:02','1','2017-01-15 21:08:02',NULL,'0'),('24534171bab7427bb2efdf49a7a0c258','115e96c89a5c444e9ef0bfdefc4c4619','e85e8494219b43269219af432babae90','8ad16a4f5f3e420ca93f03caeb9a5d12','1','2017-01-15 21:07:41','1','2017-01-15 21:07:41',NULL,'0'),('3608d6049da44bd58dd58a0526f13d67','115e96c89a5c444e9ef0bfdefc4c4619','e85e8494219b43269219af432babae90','eaa3edf9a11f4461a793b8076d405065','1','2017-01-15 21:07:41','1','2017-01-15 21:07:41',NULL,'0'),('3a59e1e8ff62440691e3f2cd9bd9076f','115e96c89a5c444e9ef0bfdefc4c4619','3acf9064949149168cdc8b705fbef2b0','2338fa9234d1451280081e43a9b11986','1','2017-01-15 21:08:02','1','2017-01-15 21:08:02',NULL,'0'),('47bd9c601b8d436faeb5a0763cbee4e2','115e96c89a5c444e9ef0bfdefc4c4619','2ec571af73a145e4a59189cae69f0ae7','850246e5e7734f54998ee240b2eb9be7','1','2017-01-15 21:08:23','1','2017-01-15 21:08:23',NULL,'0'),('54c77957337c40648e5262b24060afc4','115e96c89a5c444e9ef0bfdefc4c4619','2ec571af73a145e4a59189cae69f0ae7','be9e3da5efe74a809a33452e0ef37a56','1','2017-01-15 21:08:23','1','2017-01-15 21:08:23',NULL,'0'),('58ad9292439b493a8c1eb640b782e0b3','115e96c89a5c444e9ef0bfdefc4c4619','3acf9064949149168cdc8b705fbef2b0','38ec32b07bd2453ca36874d842e5c910','1','2017-01-15 21:08:02','1','2017-01-15 21:08:02',NULL,'0'),('814d62e499f74eea84242a9cab143e41','115e96c89a5c444e9ef0bfdefc4c4619','78a09e4c8e1c4db680fda92a0bfb391a','09c59f3d9ccf4f06afee86749397d977','1','2017-01-15 21:08:41','1','2017-01-15 21:08:41',NULL,'0'),('940ab0cd55924991abac8983eb6c14d8','115e96c89a5c444e9ef0bfdefc4c4619','e85e8494219b43269219af432babae90','d83ab608cde144fd816998b68be60782','1','2017-01-15 21:07:41','1','2017-01-15 21:07:41',NULL,'0'),('b1a7927bdfbb40c0a768bee13dc107ac','115e96c89a5c444e9ef0bfdefc4c4619','3acf9064949149168cdc8b705fbef2b0','24aafa99cfe448ca9d5054e4e489a06a','1','2017-01-15 21:08:02','1','2017-01-15 21:08:02',NULL,'0'),('d400f8f9cf824c06bc6afb9819b39504','115e96c89a5c444e9ef0bfdefc4c4619','2ec571af73a145e4a59189cae69f0ae7','4157885711ec4764a91a74be5754ff9b','1','2017-01-15 21:08:23','1','2017-01-15 21:08:23',NULL,'0'),('d529fbc8497d4e2d84ba4bb836f91805','115e96c89a5c444e9ef0bfdefc4c4619','78a09e4c8e1c4db680fda92a0bfb391a','fc5473d084b446788c7300d64cfdfb94','1','2017-01-15 21:08:41','1','2017-01-15 21:08:41',NULL,'0'),('d6a61bdcdacd4a39aded10665a2be115','115e96c89a5c444e9ef0bfdefc4c4619','3acf9064949149168cdc8b705fbef2b0','a658b8be5a7542109e1a29a9eebffc43','1','2017-01-15 21:08:02','1','2017-01-15 21:08:02',NULL,'0'),('e6bd226def2d4d789d572e8165df933c','115e96c89a5c444e9ef0bfdefc4c4619','78a09e4c8e1c4db680fda92a0bfb391a','0d01d036cdfb49f9a60121f973a7c026','1','2017-01-15 21:08:41','1','2017-01-15 21:08:41',NULL,'0'),('e935d9b9ee7243a8b772900b047f5130','115e96c89a5c444e9ef0bfdefc4c4619','78a09e4c8e1c4db680fda92a0bfb391a','a4fae3a7f2904340a2631026b5aacd55','1','2017-01-15 21:08:41','1','2017-01-15 21:08:41',NULL,'0'),('f703f6ea0d1a4b37bead90f16dde173d','115e96c89a5c444e9ef0bfdefc4c4619','2ec571af73a145e4a59189cae69f0ae7','3f47d4cae93b402d9522f214742f8afa','1','2017-01-15 21:08:23','1','2017-01-15 21:08:23',NULL,'0'),('fc54b8e042324e9bbcfaf23829b739d5','115e96c89a5c444e9ef0bfdefc4c4619','e85e8494219b43269219af432babae90','57711e419e3b45dba5b5d2f25af13a09','1','2017-01-15 21:07:41','1','2017-01-15 21:07:41',NULL,'0'),('fee641d620764061a34f0e4b0a7d77c0','115e96c89a5c444e9ef0bfdefc4c4619','e85e8494219b43269219af432babae90','9b0542df9df04e4db2f8e0763c1a63f8','1','2017-01-15 21:07:41','1','2017-01-15 21:07:41',NULL,'0');

/*Table structure for table `cdboo_user_group_channel` */

DROP TABLE IF EXISTS `cdboo_user_group_channel`;

CREATE TABLE `cdboo_user_group_channel` (
  `id` varchar(64) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户频道关联表id',
  `group_channel_id` varchar(64) DEFAULT NULL COMMENT '组合频道id',
  `create_by` varchar(64) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_user_group_channel` */

insert  into `cdboo_user_group_channel`(`id`,`user_id`,`group_channel_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('05d1bd0052bf4af6b7d5f16e9a0c5989','115e96c89a5c444e9ef0bfdefc4c4619','e745c6fd278d4ed1bd888a578f7f8ac8','1','2017-01-15 21:09:13','1','2017-01-15 21:09:13',NULL,'0');

/*Table structure for table `cdboo_user_service` */

DROP TABLE IF EXISTS `cdboo_user_service`;

CREATE TABLE `cdboo_user_service` (
  `id` varchar(32) NOT NULL COMMENT 'id',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  `contract_start_time` datetime DEFAULT NULL COMMENT '合同开始时间',
  `contract_end_time` datetime DEFAULT NULL COMMENT '合同结束时间',
  `service_note` longtext COMMENT '服务说明',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL COMMENT '删除标志0正常1删除',
  `status` int(1) DEFAULT NULL COMMENT '状态位显示',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_user_service` */

/*Table structure for table `cdboo_user_timestep` */

DROP TABLE IF EXISTS `cdboo_user_timestep`;

CREATE TABLE `cdboo_user_timestep` (
  `id` varchar(64) NOT NULL,
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  `name` varchar(64) DEFAULT NULL COMMENT '时段名称',
  `start_time` time DEFAULT NULL COMMENT '开始时间',
  `end_time` time DEFAULT NULL COMMENT '结束时间',
  `create_by` varchar(64) NOT NULL COMMENT '创建人',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_date` datetime DEFAULT NULL COMMENT '修改时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cdboo_user_timestep` */

insert  into `cdboo_user_timestep`(`id`,`user_id`,`name`,`start_time`,`end_time`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('195966b4af194dac803a06f8cd4c91e5','115e96c89a5c444e9ef0bfdefc4c4619','日落','17:00:00','20:00:00','1','2017-01-15 21:10:58','1','2017-01-15 21:10:58','','0'),('4fc4ccfc066140c9b03af25bc277f2cc','115e96c89a5c444e9ef0bfdefc4c4619','中午','11:00:00','14:00:00','1','2017-01-15 21:10:33','1','2017-01-15 21:10:33','','0'),('66fdb614ce1547cbab037b68122b525f','115e96c89a5c444e9ef0bfdefc4c4619','午夜','22:00:00','00:00:00','1','2017-01-15 21:11:21','1','2017-01-15 21:11:21','','0'),('8fb5a7e49e4b4d65b46eb2c723a867ef','115e96c89a5c444e9ef0bfdefc4c4619','晚间','20:00:00','22:00:00','1','2017-01-15 21:11:08','1','2017-01-15 21:11:08','','0'),('9bc8d46101dc4f83853881921eb922a8','115e96c89a5c444e9ef0bfdefc4c4619','凌晨','00:00:00','06:00:00','1','2017-01-15 21:10:04','1','2017-01-15 21:10:04','','0'),('a7f602677bd84bb4817e1e1b0a4cac9e','115e96c89a5c444e9ef0bfdefc4c4619','上午','09:00:00','11:00:00','1','2017-01-15 21:10:22','1','2017-01-15 21:10:22','','0'),('c978305ea064427b85453c0294077a18','115e96c89a5c444e9ef0bfdefc4c4619','下午','14:00:00','17:00:00','1','2017-01-15 21:10:45','1','2017-01-15 21:10:45','','0'),('e35a17955be94e0e8608e16c06a6930a','115e96c89a5c444e9ef0bfdefc4c4619','晨醒','06:00:00','09:00:00','1','2017-01-15 21:10:14','1','2017-01-15 21:10:14','','0');

/*Table structure for table `cms_article` */

DROP TABLE IF EXISTS `cms_article`;

CREATE TABLE `cms_article` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '标题',
  `link` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章链接',
  `color` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章图片',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述、摘要',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `hits` int(11) DEFAULT '0' COMMENT '点击数',
  `posid` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '推荐位，多选',
  `custom_content_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8_bin COMMENT '视图配置',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_article_create_by` (`create_by`),
  KEY `cms_article_title` (`title`),
  KEY `cms_article_keywords` (`keywords`),
  KEY `cms_article_del_flag` (`del_flag`),
  KEY `cms_article_weight` (`weight`),
  KEY `cms_article_update_date` (`update_date`),
  KEY `cms_article_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='文章表';

/*Data for the table `cms_article` */

insert  into `cms_article`(`id`,`category_id`,`title`,`link`,`color`,`image`,`keywords`,`description`,`weight`,`weight_date`,`hits`,`posid`,`custom_content_view`,`view_config`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('1','3','文章标题标题标题标题',NULL,'green',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('10','4','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('11','5','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('12','5','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('13','5','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('14','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('15','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('16','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('17','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('18','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('19','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2','3','文章标题标题标题标题',NULL,'red',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('20','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('21','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('22','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('23','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('24','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('25','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('26','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('27','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('28','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('29','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3','3','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('30','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('31','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('32','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('33','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('34','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('35','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('36','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('37','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('38','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('39','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('4','3','文章标题标题标题标题',NULL,'green',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('40','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('41','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('42','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('43','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('44','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('45','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('46','15','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('47','15','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('48','15','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('49','16','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5','3','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('50','17','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('51','17','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('52','26','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('53','26','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('6','3','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('7','4','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('8','4','文章标题标题标题标题',NULL,'blue',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('9','4','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0');

/*Table structure for table `cms_article_data` */

DROP TABLE IF EXISTS `cms_article_data`;

CREATE TABLE `cms_article_data` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `content` text COLLATE utf8_bin COMMENT '文章内容',
  `copyfrom` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '文章来源',
  `relation` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '相关文章',
  `allow_comment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='文章详表';

/*Data for the table `cms_article_data` */

insert  into `cms_article_data`(`id`,`content`,`copyfrom`,`relation`,`allow_comment`) values ('1','文章内容内容内容内容','来源','1,2,3','1'),('10','文章内容内容内容内容','来源','1,2,3','1'),('11','文章内容内容内容内容','来源','1,2,3','1'),('12','文章内容内容内容内容','来源','1,2,3','1'),('13','文章内容内容内容内容','来源','1,2,3','1'),('14','文章内容内容内容内容','来源','1,2,3','1'),('15','文章内容内容内容内容','来源','1,2,3','1'),('16','文章内容内容内容内容','来源','1,2,3','1'),('17','文章内容内容内容内容','来源','1,2,3','1'),('18','文章内容内容内容内容','来源','1,2,3','1'),('19','文章内容内容内容内容','来源','1,2,3','1'),('2','文章内容内容内容内容','来源','1,2,3','1'),('20','文章内容内容内容内容','来源','1,2,3','1'),('21','文章内容内容内容内容','来源','1,2,3','1'),('22','文章内容内容内容内容','来源','1,2,3','1'),('23','文章内容内容内容内容','来源','1,2,3','1'),('24','文章内容内容内容内容','来源','1,2,3','1'),('25','文章内容内容内容内容','来源','1,2,3','1'),('26','文章内容内容内容内容','来源','1,2,3','1'),('27','文章内容内容内容内容','来源','1,2,3','1'),('28','文章内容内容内容内容','来源','1,2,3','1'),('29','文章内容内容内容内容','来源','1,2,3','1'),('3','文章内容内容内容内容','来源','1,2,3','1'),('30','文章内容内容内容内容','来源','1,2,3','1'),('31','文章内容内容内容内容','来源','1,2,3','1'),('32','文章内容内容内容内容','来源','1,2,3','1'),('33','文章内容内容内容内容','来源','1,2,3','1'),('34','文章内容内容内容内容','来源','1,2,3','1'),('35','文章内容内容内容内容','来源','1,2,3','1'),('36','文章内容内容内容内容','来源','1,2,3','1'),('37','文章内容内容内容内容','来源','1,2,3','1'),('38','文章内容内容内容内容','来源','1,2,3','1'),('39','文章内容内容内容内容','来源','1,2,3','1'),('4','文章内容内容内容内容','来源','1,2,3','1'),('40','文章内容内容内容内容','来源','1,2,3','1'),('41','文章内容内容内容内容','来源','1,2,3','1'),('42','文章内容内容内容内容','来源','1,2,3','1'),('43','文章内容内容内容内容','来源','1,2,3','1'),('44','文章内容内容内容内容','来源','1,2,3','1'),('45','文章内容内容内容内容','来源','1,2,3','1'),('46','文章内容内容内容内容','来源','1,2,3','1'),('47','文章内容内容内容内容','来源','1,2,3','1'),('48','文章内容内容内容内容','来源','1,2,3','1'),('49','文章内容内容内容内容','来源','1,2,3','1'),('5','文章内容内容内容内容','来源','1,2,3','1'),('50','文章内容内容内容内容','来源','1,2,3','1'),('51','文章内容内容内容内容','来源','1,2,3','1'),('52','文章内容内容内容内容','来源','1,2,3','1'),('53','文章内容内容内容内容','来源','1,2,3','1'),('6','文章内容内容内容内容','来源','1,2,3','1'),('7','文章内容内容内容内容','来源','1,2,3','1'),('8','文章内容内容内容内容','来源','1,2,3','1'),('9','文章内容内容内容内容','来源','1,2,3','1');

/*Table structure for table `cms_category` */

DROP TABLE IF EXISTS `cms_category`;

CREATE TABLE `cms_category` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `site_id` varchar(64) COLLATE utf8_bin DEFAULT '1' COMMENT '站点编号',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `module` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目模块',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '栏目名称',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目图片',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `sort` int(11) DEFAULT '30' COMMENT '排序（升序）',
  `in_menu` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否在导航中显示',
  `in_list` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否在分类页中显示列表',
  `show_modes` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '展现方式',
  `allow_comment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否允许评论',
  `is_audit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否需要审核',
  `custom_list_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义列表视图',
  `custom_content_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义内容视图',
  `view_config` text COLLATE utf8_bin COMMENT '视图配置',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_category_parent_id` (`parent_id`),
  KEY `cms_category_module` (`module`),
  KEY `cms_category_name` (`name`),
  KEY `cms_category_sort` (`sort`),
  KEY `cms_category_del_flag` (`del_flag`),
  KEY `cms_category_office_id` (`office_id`),
  KEY `cms_category_site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='栏目表';

/*Data for the table `cms_category` */

insert  into `cms_category`(`id`,`parent_id`,`parent_ids`,`site_id`,`office_id`,`module`,`name`,`image`,`href`,`target`,`description`,`keywords`,`sort`,`in_menu`,`in_list`,`show_modes`,`allow_comment`,`is_audit`,`custom_list_view`,`custom_content_view`,`view_config`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('1','0','0,','0','1',NULL,'顶级栏目',NULL,NULL,NULL,NULL,NULL,0,'1','1','0','0','1',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('10','1','0,1,','1','4','article','软件介绍',NULL,NULL,NULL,NULL,NULL,20,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('11','10','0,1,10,','1','4','article','网络工具',NULL,NULL,NULL,NULL,NULL,30,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('12','10','0,1,10,','1','4','article','浏览工具',NULL,NULL,NULL,NULL,NULL,40,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('13','10','0,1,10,','1','4','article','浏览辅助',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('14','10','0,1,10,','1','4','article','网络优化',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('15','10','0,1,10,','1','4','article','邮件处理',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('16','10','0,1,10,','1','4','article','下载工具',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('17','10','0,1,10,','1','4','article','搜索工具',NULL,NULL,NULL,NULL,NULL,50,'1','1','2','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('18','1','0,1,','1','5','link','友情链接',NULL,NULL,NULL,NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('19','18','0,1,18,','1','5','link','常用网站',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2','1','0,1,','1','3','article','组织机构',NULL,NULL,NULL,NULL,NULL,10,'1','1','0','0','1',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('20','18','0,1,18,','1','5','link','门户网站',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('21','18','0,1,18,','1','5','link','购物网站',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('22','18','0,1,18,','1','5','link','交友社区',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('23','18','0,1,18,','1','5','link','音乐视频',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('24','1','0,1,','1','6',NULL,'百度一下',NULL,'http://www.baidu.com','_blank',NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('25','1','0,1,','1','6',NULL,'全文检索',NULL,'/search',NULL,NULL,NULL,90,'0','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('26','1','0,1,','2','6','article','测试栏目',NULL,NULL,NULL,NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('27','1','0,1,','1','6',NULL,'公共留言',NULL,'/guestbook',NULL,NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3','2','0,1,2,','1','3','article','网站简介',NULL,NULL,NULL,NULL,NULL,30,'1','1','0','0','1',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('4','2','0,1,2,','1','3','article','内部机构',NULL,NULL,NULL,NULL,NULL,40,'1','1','0','0','1',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5','2','0,1,2,','1','3','article','地方机构',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','0','1',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('6','1','0,1,','1','3','article','质量检验',NULL,NULL,NULL,NULL,NULL,20,'1','1','1','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('7','6','0,1,6,','1','3','article','产品质量',NULL,NULL,NULL,NULL,NULL,30,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('8','6','0,1,6,','1','3','article','技术质量',NULL,NULL,NULL,NULL,NULL,40,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('9','6','0,1,6,','1','3','article','工程质量',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0');

/*Table structure for table `cms_comment` */

DROP TABLE IF EXISTS `cms_comment`;

CREATE TABLE `cms_comment` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `content_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目内容的编号',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '栏目内容的标题',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '评论内容',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '评论姓名',
  `ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '评论IP',
  `create_date` datetime NOT NULL COMMENT '评论时间',
  `audit_user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '审核人',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_comment_category_id` (`category_id`),
  KEY `cms_comment_content_id` (`content_id`),
  KEY `cms_comment_status` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='评论表';

/*Data for the table `cms_comment` */

/*Table structure for table `cms_guestbook` */

DROP TABLE IF EXISTS `cms_guestbook`;

CREATE TABLE `cms_guestbook` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '留言分类',
  `content` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '留言内容',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `phone` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '电话',
  `workunit` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '单位',
  `ip` varchar(100) COLLATE utf8_bin NOT NULL COMMENT 'IP',
  `create_date` datetime NOT NULL COMMENT '留言时间',
  `re_user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '回复人',
  `re_date` datetime DEFAULT NULL COMMENT '回复时间',
  `re_content` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '回复内容',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_guestbook_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='留言板';

/*Data for the table `cms_guestbook` */

/*Table structure for table `cms_link` */

DROP TABLE IF EXISTS `cms_link`;

CREATE TABLE `cms_link` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `category_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '栏目编号',
  `title` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '链接名称',
  `color` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '标题颜色',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接图片',
  `href` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '链接地址',
  `weight` int(11) DEFAULT '0' COMMENT '权重，越大越靠前',
  `weight_date` datetime DEFAULT NULL COMMENT '权重期限',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_link_category_id` (`category_id`),
  KEY `cms_link_title` (`title`),
  KEY `cms_link_del_flag` (`del_flag`),
  KEY `cms_link_weight` (`weight`),
  KEY `cms_link_create_by` (`create_by`),
  KEY `cms_link_update_date` (`update_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='友情链接';

/*Data for the table `cms_link` */

insert  into `cms_link`(`id`,`category_id`,`title`,`color`,`image`,`href`,`weight`,`weight_date`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('1','19','JeeSite',NULL,NULL,'http://thinkgem.github.com/jeesite',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('10','22','58同城',NULL,NULL,'http://www.58.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('11','23','视频大全',NULL,NULL,'http://v.360.cn/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('12','23','凤凰网',NULL,NULL,'http://www.ifeng.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2','19','ThinkGem',NULL,NULL,'http://thinkgem.iteye.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3','19','百度一下',NULL,NULL,'http://www.baidu.com',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('4','19','谷歌搜索',NULL,NULL,'http://www.google.com',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5','20','新浪网',NULL,NULL,'http://www.sina.com.cn',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('6','20','腾讯网',NULL,NULL,'http://www.qq.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('7','21','淘宝网',NULL,NULL,'http://www.taobao.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('8','21','新华网',NULL,NULL,'http://www.xinhuanet.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('9','22','赶集网',NULL,NULL,'http://www.ganji.com/',0,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0');

/*Table structure for table `cms_site` */

DROP TABLE IF EXISTS `cms_site`;

CREATE TABLE `cms_site` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '站点名称',
  `title` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '站点标题',
  `logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '站点Logo',
  `domain` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '站点域名',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `keywords` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '关键字',
  `theme` varchar(255) COLLATE utf8_bin DEFAULT 'default' COMMENT '主题',
  `copyright` text COLLATE utf8_bin COMMENT '版权信息',
  `custom_index_view` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义站点首页视图',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `cms_site_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='站点表';

/*Data for the table `cms_site` */

insert  into `cms_site`(`id`,`name`,`title`,`logo`,`domain`,`description`,`keywords`,`theme`,`copyright`,`custom_index_view`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('1','默认站点','JeeSite Web',NULL,NULL,'JeeSite','JeeSite','basic','Copyright &copy; 2012-2013 <a href=\'http://thinkgem.iteye.com\' target=\'_blank\'>ThinkGem</a> - Powered By <a href=\'https://github.com/thinkgem/jeesite\' target=\'_blank\'>JeeSite</a> V1.0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2','子站点测试','JeeSite Subsite',NULL,NULL,'JeeSite subsite','JeeSite subsite','basic','Copyright &copy; 2012-2013 <a href=\'http://thinkgem.iteye.com\' target=\'_blank\'>ThinkGem</a> - Powered By <a href=\'https://github.com/thinkgem/jeesite\' target=\'_blank\'>JeeSite</a> V1.0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0');

/*Table structure for table `gen_scheme` */

DROP TABLE IF EXISTS `gen_scheme`;

CREATE TABLE `gen_scheme` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `package_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成表编号',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_scheme_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='生成方案';

/*Data for the table `gen_scheme` */

insert  into `gen_scheme`(`id`,`name`,`category`,`package_name`,`module_name`,`sub_module_name`,`function_name`,`function_name_simple`,`function_author`,`gen_table_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('2f1a5e966f8f480b8f3543905f90fd8b','用户计划生成方案','curd','com.cdboo','userplan','','用户计划表','用户计划','yubin','2191a2fd805b4b00ac99a17d043f773f','1','2016-12-21 15:48:42','1','2016-12-21 15:48:45','','0'),('35a13dc260284a728a270db3f382664b','树结构','treeTable','com.thinkgem.jeesite.modules','test',NULL,'树结构生成','树结构','ThinkGem','f6e4dafaa72f4c509636484715f33a96','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('3963cc0b6dad45aca0d2944f7484b7bf','用户频道表生成方案','curd','com.cdboo','userchannel','','用户频道表','用户频道','yubin','43803e0d1b224476a13611431620309b','1','2016-12-21 15:30:42','1','2016-12-21 15:32:26','','0'),('4257ec4aaa3144cfbd8f585719aeaad6','频道表生成','curd','com.cdboo','channel','','频道管理','频道信息','于滨','68ad4e53333a4b48ae3075261cf67ee1','1','2016-12-17 12:35:45','1','2016-12-17 12:35:45','','0'),('494c07bcbffc43a6a8b090838a3cc28c','时段管理','curd','com.cdboo','timestep','','时段管理','时段','朱广成','162a3efb92964941a4724ff42789da99','1','2016-12-13 11:23:57','1','2016-12-13 11:23:57','','0'),('4e0a59e07bbf45fa86153de4bcc4ed50','用户曲库生成方案','curd','com.cdboo','usermusic','','用户曲库信息','用户曲库信息','yubin','757a8de6211d4f6dbe5141f20d53d870','1','2016-12-21 15:45:22','1','2016-12-21 15:46:00','','0'),('7a7d1ad58242450d94fe862acfe6a7b1','插播计划生成方案','curd','com.cdboo','musicinsert','','插播计划表','插播计划','yubin','d73eaf376981483e8765be4febdb4d74','1','2016-12-21 15:49:43','1','2016-12-21 15:49:43','','0'),('810340d4b02d41dab9399931bbfadf30','曲库生成','curd','com.cdboo','music','','曲库管理','歌曲信息','yubin','ee76a95e512f489d9a02b219cd9afe5f','1','2016-12-13 10:43:57','1','2016-12-17 11:46:00','','0'),('90a93d41b2274257ae22de728cab02d3','用户服务信息表生成方案','curd','com.cdboo','userservice','','用户服务信息','用户服务信息','yubin','e703b9720b584233a490deff3287b4b0','1','2016-12-21 15:47:22','1','2016-12-21 15:47:22','','0'),('98b405b808df4dd1af60f3bd418249b2','首页','curd','com.cdboo','taluser','','首页功能','home','wn','2f1e237dba2b4d41b6145fd23e4f9ba5','1','2016-11-24 13:54:54','1','2016-12-28 13:55:50','','0'),('98ecf6062a1241b88eb2611db70f740f','组合频道子表生成策略','dao','com.cdboo','childchannel','','组合频道子表','组合频道子表','yubin','acf218bf9a2f4ac297ae378a44667c5c','1','2016-12-29 14:29:29','1','2016-12-29 14:29:37','','0'),('9c9de9db6da743bb899036c6546061ac','单表','curd','com.thinkgem.jeesite.modules','test',NULL,'单表生成','单表','ThinkGem','aef6f1fc948f4c9ab1c1b780bc471cc2','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('e2a6dcc65a94451bb7a660f9f9b20e31','行业时段','treeTableAndList','com.cdboo','businesstime','','行业时段','行业时段','朱广成','ead88eabb0644854a2c64a80b5ad16e9','1','2016-12-13 10:33:42','1','2016-12-13 10:45:09','','0'),('e6d905fd236b46d1af581dd32bdfb3b0','主子表','curd_many','com.thinkgem.jeesite.modules','test',NULL,'主子表生成','主子表','ThinkGem','43d6d5acffa14c258340ce6765e46c6f','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('ecafe0af35b34ecc95b2342a210e9bcd','曲库生成（仅有表）','dao','com.cdboo','music','','曲库管理','歌曲信息','于滨','ee76a95e512f489d9a02b219cd9afe5f','1','2016-12-17 11:31:50','1','2016-12-17 11:48:13','','0'),('fb543367163e4e35a0c8fb3a7bb13905','用户时段表生成方案','curd','com.cdboo','usertimestep','','用户时段信息','用户时段','yubin','6ef293fc5e904236b941a896779d78c5','1','2016-12-21 15:44:23','1','2016-12-21 15:44:23','','0');

/*Table structure for table `gen_table` */

DROP TABLE IF EXISTS `gen_table`;

CREATE TABLE `gen_table` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `class_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '关联父表外键',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_name` (`name`),
  KEY `gen_table_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务表';

/*Data for the table `gen_table` */

insert  into `gen_table`(`id`,`name`,`comments`,`class_name`,`parent_table`,`parent_table_fk`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('162a3efb92964941a4724ff42789da99','cdboo_timestep','时段','Timestep','','','1','2016-12-13 11:21:55','1','2016-12-13 11:21:55','','0'),('2191a2fd805b4b00ac99a17d043f773f','cdboo_plan','用户计划表','CdbooPlan','','','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56','','0'),('2f1e237dba2b4d41b6145fd23e4f9ba5','tal_user','首页','TalUser','','','1','2016-11-24 13:26:24','1','2016-12-28 13:53:34','','0'),('33cec7d732734d40aa1cda723f398c33','cdboo_music','曲库表','CdbooMusic','','','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18','','1'),('43803e0d1b224476a13611431620309b','cdboo_user_channel','用户频道表','CdbooUserChannel','','','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32','','0'),('43d6d5acffa14c258340ce6765e46c6f','test_data_main','业务数据表','TestDataMain',NULL,NULL,'1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('68ad4e53333a4b48ae3075261cf67ee1','cdboo_child_channel','频道表','CdbooChannel','','','1','2016-12-17 12:17:51','1','2016-12-17 13:35:08','','0'),('6e05c389f3c6415ea34e55e9dfb28934','test_data_child','业务数据子表','TestDataChild','test_data_main','test_data_main_id','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('6ef293fc5e904236b941a896779d78c5','cdboo_user_timestep','用户时段表','CdbooUserTimestep','','','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09','','0'),('757a8de6211d4f6dbe5141f20d53d870','cdboo_owner_music','用户曲库表','CdbooOwnerMusic','','','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01','','0'),('acf218bf9a2f4ac297ae378a44667c5c','cdboo_group_child','组合频道子表','CdbooGroupChild','','','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08','','0'),('aef6f1fc948f4c9ab1c1b780bc471cc2','test_data','业务数据表','TestData',NULL,NULL,'1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('d73eaf376981483e8765be4febdb4d74','cdboo_music_insert','插播计划表','CdbooMusicInsert','','','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13','','0'),('e703b9720b584233a490deff3287b4b0','cdboo_user_service','用户服务信息表','CdbooUserService','','','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59','','0'),('ead88eabb0644854a2c64a80b5ad16e9','cdboo_business','行业','Business','','','1','2016-12-13 10:21:40','1','2016-12-13 10:24:28','','0'),('ee76a95e512f489d9a02b219cd9afe5f','cdboo_music','曲库表','CdbooMusic','','','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46','','0'),('f6e4dafaa72f4c509636484715f33a96','test_tree','树结构表','TestTree',NULL,NULL,'1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0');

/*Table structure for table `gen_table_column` */

DROP TABLE IF EXISTS `gen_table_column`;

CREATE TABLE `gen_table_column` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_table_column_table_id` (`gen_table_id`),
  KEY `gen_table_column_name` (`name`),
  KEY `gen_table_column_sort` (`sort`),
  KEY `gen_table_column_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务表字段';

/*Data for the table `gen_table_column` */

insert  into `gen_table_column`(`id`,`gen_table_id`,`name`,`comments`,`jdbc_type`,`java_type`,`java_field`,`is_pk`,`is_null`,`is_insert`,`is_edit`,`is_list`,`is_query`,`query_type`,`show_type`,`dict_type`,`settings`,`sort`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('077a04c876ab46fa8855cf98fbe2bb2e','162a3efb92964941a4724ff42789da99','starttime','开始时间','time','String','starttime','0','1','1','1','1','1','between','dateselect','',NULL,'40','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('08132d4985ec46279bdb03b4b3f4c884','757a8de6211d4f6dbe5141f20d53d870','update_date','更新时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'70','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('08db1652c9a34c5a896dea4f2dcff284','2f1e237dba2b4d41b6145fd23e4f9ba5','email','邮箱','varchar(200)','String','email','0','1','1','1','1','1','=','input','',NULL,'60','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('0902a0cb3e8f434280c20e9d771d0658','aef6f1fc948f4c9ab1c1b780bc471cc2','sex','性别','char(1)','String','sex','0','1','1','1','1','1','=','radiobox','sex',NULL,'6','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('0a71bc623012495a8dcec74fccb5df68','757a8de6211d4f6dbe5141f20d53d870','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','1','0','=','input','',NULL,'40','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('0ae5a51ea2a84396942e8bee39ee875d','68ad4e53333a4b48ae3075261cf67ee1','id','id','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-17 12:17:51','1','2016-12-17 13:35:08',NULL,'0'),('0af2327deefa48c98f6d8b4a26ef74d9','ead88eabb0644854a2c64a80b5ad16e9','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-13 10:21:40','1','2016-12-13 10:24:28',NULL,'0'),('0af8e67ce0b84addaf83a42f32272b2c','162a3efb92964941a4724ff42789da99','timestep_no','时段编号','varchar(100)','String','timestepNo','0','1','1','1','1','1','=','input','',NULL,'20','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('0b580e0b4f884f2fb5e227276bca2571','68ad4e53333a4b48ae3075261cf67ee1','photo_path','频道图片','varchar(2000)','String','photoPath','0','1','1','1','1','0','=','input','',NULL,'40','1','2016-12-17 12:17:51','1','2016-12-17 13:35:08',NULL,'0'),('0bce62fb4fa449feab79deab03d8b20d','d73eaf376981483e8765be4febdb4d74','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'130','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('0ca2274e11a545a0a1ecae1f755c1ebe','2f1e237dba2b4d41b6145fd23e4f9ba5','del_flag','删除标记','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'190','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('0cf254798cef403cbf1ddf66d5de3886','6ef293fc5e904236b941a896779d78c5','id','id','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('0ef583cfd3354226a11876638d73fc37','2191a2fd805b4b00ac99a17d043f773f','user_id','用户id','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect','',NULL,'40','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('10282a7a1ecc4592b72a15b3f7e0a105','ee76a95e512f489d9a02b219cd9afe5f','update_date','更新时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'110','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('103fc05c88ff40639875c2111881996a','aef6f1fc948f4c9ab1c1b780bc471cc2','create_date','创建时间','timestamp(6)','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect',NULL,NULL,'9','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('115197c568f443de97a266e8e372e4e3','2f1e237dba2b4d41b6145fd23e4f9ba5','phone','电话','varchar(200)','String','phone','0','1','1','1','1','1','=','input','',NULL,'70','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('117545781127449ea353cafb39d8503c','ead88eabb0644854a2c64a80b5ad16e9','update_date','更新时间','datetime','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect','',NULL,'100','1','2016-12-13 10:21:42','1','2016-12-13 10:24:29',NULL,'0'),('12fa38dd986e41908f7fefa5839d1220','6e05c389f3c6415ea34e55e9dfb28934','create_by','创建者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input',NULL,NULL,'4','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('146aaee8d985411e888e6a3804dce1a0','d73eaf376981483e8765be4febdb4d74','insert_no','插播编号','varchar(100)','String','insertNo','0','1','1','1','1','1','=','input','',NULL,'20','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('14a82f3294294acfad6dabae474d6036','757a8de6211d4f6dbe5141f20d53d870','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'80','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('14fb3825bd414c9e9a9700ece78feb0e','c3c293ec079d49c689f38ac82f989593','update_date','更新时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'90','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('159ff52bea7f4d2fbd01ef904952b374','c3c293ec079d49c689f38ac82f989593','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'100','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('15a41fc5a1f74ebf87483a3987c55269','ee76a95e512f489d9a02b219cd9afe5f','volume','音量','varchar(10)','String','volume','0','1','1','1','1','0','=','input','',NULL,'70','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('195ee9241f954d008fe01625f4adbfef','f6e4dafaa72f4c509636484715f33a96','create_by','创建者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input',NULL,NULL,'6','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('19c6478b8ff54c60910c2e4fc3d27503','43d6d5acffa14c258340ce6765e46c6f','id','编号','varchar2(64)','String','id','1','0','1','0','0','0','=','input',NULL,NULL,'1','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('19ce0b0087c049c3b0be2312449c84b1','757a8de6211d4f6dbe5141f20d53d870','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('1ac6562f753d4e599693840651ab2bf7','43d6d5acffa14c258340ce6765e46c6f','in_date','加入日期','date(7)','java.util.Date','inDate','0','1','1','1','0','0','=','dateselect',NULL,NULL,'7','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('1b29717a07f54662a7ecea36004876c2','33cec7d732734d40aa1cda723f398c33','music_no','音乐编号','varchar(100)','String','musicNo','0','1','1','1','1','1','=','input','',NULL,'20','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('1b8eb55f65284fa6b0a5879b6d8ad3ec','aef6f1fc948f4c9ab1c1b780bc471cc2','in_date','加入日期','date(7)','java.util.Date','inDate','0','1','1','1','0','1','between','dateselect',NULL,NULL,'7','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('1d5ca4d114be41e99f8dc42a682ba609','aef6f1fc948f4c9ab1c1b780bc471cc2','user_id','归属用户','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect',NULL,NULL,'2','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('1d65e857b30944dc9f2a9c805e76bb70','68ad4e53333a4b48ae3075261cf67ee1','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'170','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('1e79098a697543e18536578f6243fc35','68ad4e53333a4b48ae3075261cf67ee1','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','1','between','dateselect','',NULL,'160','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('1ed6d07049e84d59839c5390986b3a3e','2191a2fd805b4b00ac99a17d043f773f','week','日期','varchar(255)','String','week','0','1','1','1','1','0','=','input','',NULL,'80','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('1f376c2f6f784ee889e529f34718327a','ead88eabb0644854a2c64a80b5ad16e9','remarks','备注信息','varchar(1000)','String','remarks','0','1','1','1','1','0','=','textarea','',NULL,'110','1','2016-12-13 10:21:42','1','2016-12-13 10:24:30',NULL,'0'),('20cd07f7d648488bacd1265b857a2455','2f1e237dba2b4d41b6145fd23e4f9ba5','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','1','=','dateselect','',NULL,'150','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('2164c9e403064006a2f27c15f68270c1','68ad4e53333a4b48ae3075261cf67ee1','site','场所','varchar(100)','String','site','0','1','1','1','0','1','=','select','site_type',NULL,'90','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('21756504ffdc487eb167a823f89c0c06','43d6d5acffa14c258340ce6765e46c6f','update_by','更新者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input',NULL,NULL,'10','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('228e2c32f12a49fe92f5d517e59ed275','68ad4e53333a4b48ae3075261cf67ee1','music_style','音乐风格','varchar(100)','String','musicStyle','0','1','1','1','0','1','=','select','music_style',NULL,'80','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('22ee79f6ffe5488e98833ea54d1fac00','2191a2fd805b4b00ac99a17d043f773f','play_name','计划名称','varchar(100)','String','playName','0','1','1','1','1','1','=','input','',NULL,'30','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('24bbdc0a555e4412a106ab1c5f03008e','f6e4dafaa72f4c509636484715f33a96','parent_ids','所有父级编号','varchar2(2000)','String','parentIds','0','0','1','1','0','0','like','input',NULL,NULL,'3','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('266448bee40044c59ab8b45e87f093d4','ee76a95e512f489d9a02b219cd9afe5f','status','状态','char(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'140','1','2016-12-17 11:30:28','1','2016-12-17 11:45:47',NULL,'0'),('26c74fa3f2ab4f8aa2358419a35a4c3f','ee76a95e512f489d9a02b219cd9afe5f','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','1','between','dateselect','',NULL,'90','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('26f2056917334b02a06244ab6e4bb448','d73eaf376981483e8765be4febdb4d74','update_date','更新时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'120','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('278a65adb607431b969c938d4533c4ad','33cec7d732734d40aa1cda723f398c33','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','0','1','=','dateselect','',NULL,'90','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('2814e2ee9f61494bad1cb8928655c172','2f1e237dba2b4d41b6145fd23e4f9ba5','id','编号','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-11-24 13:26:24','1','2016-12-28 13:53:34',NULL,'0'),('285f9c30e0584d8e9cbd1ed7ab7a400a','ee76a95e512f489d9a02b219cd9afe5f','special','专辑','varchar(100)','String','special','0','1','1','1','1','1','=','input','',NULL,'60','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('28b8a24b7e0148ae9f7cbb487eb0498c','c3c293ec079d49c689f38ac82f989593','del_flag','删除标记','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'110','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('28ba6d3c3bf04f85a22e93a379eb76a4','c3c293ec079d49c689f38ac82f989593','address','机构地址','varchar(128)','String','address','0','1','1','1','0','0','=','input','',NULL,'50','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('2c6b5a6eea6c4d57a560675a062390ce','ead88eabb0644854a2c64a80b5ad16e9','update_by','更新者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input','',NULL,'90','1','2016-12-13 10:21:42','1','2016-12-13 10:24:29',NULL,'0'),('313ebc78359748559c42a131d6df7484','2191a2fd805b4b00ac99a17d043f773f','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input','',NULL,'130','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('3246cd33244c490dbaacc0d04902b37e','68ad4e53333a4b48ae3075261cf67ee1','del_flag','删除标志','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'200','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('32fd860df894485dadbf1d223f42d8bb','2191a2fd805b4b00ac99a17d043f773f','music_style','风格','varchar(255)','String','musicStyle','0','1','1','1','1','1','=','select','',NULL,'70','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('33152ce420904594b3eac796a27f0560','6e05c389f3c6415ea34e55e9dfb28934','id','编号','varchar2(64)','String','id','1','0','1','0','0','0','=','input',NULL,NULL,'1','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('35af241859624a01917ab64c3f4f0813','aef6f1fc948f4c9ab1c1b780bc471cc2','del_flag','删除标记（0：正常；1：删除）','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'13','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('37fb71c3275c42818f9c22a5f348d70c','acf218bf9a2f4ac297ae378a44667c5c','update_date','更新时间','datetime','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect','',NULL,'70','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('382ada6704824449aa076e10ec54cce1','757a8de6211d4f6dbe5141f20d53d870','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','0','=','dateselect','',NULL,'50','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('386c7769e8f7478ea9b6d7fb7b83912c','e703b9720b584233a490deff3287b4b0','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','1','0','=','textarea','',NULL,'100','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('398b4a03f06940bfb979ca574e1911e3','aef6f1fc948f4c9ab1c1b780bc471cc2','create_by','创建者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input',NULL,NULL,'8','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('39f9e50e862c4fbdaa419948b773f171','e703b9720b584233a490deff3287b4b0','update_date','更新时间','datetime','java.util.Date','updateDate','0','1','1','1','1','0','=','dateselect','',NULL,'90','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('3a7cf23ae48a4c849ceb03feffc7a524','43d6d5acffa14c258340ce6765e46c6f','area_id','归属区域','nvarchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.Area','area.id|name','0','1','1','1','0','0','=','areaselect',NULL,NULL,'4','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('3c775e4e7e534193915b2595503f9226','acf218bf9a2f4ac297ae378a44667c5c','child_channel_id','子频道','varchar(32)','com.cdboo.channel.entity.CdbooChannel','childChannelId.id','0','1','1','1','0','0','=','input','',NULL,'30','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('3d9c32865bb44e85af73381df0ffbf3d','43d6d5acffa14c258340ce6765e46c6f','update_date','更新时间','timestamp(6)','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect',NULL,NULL,'11','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('3dd2de9a48164164bb7d22176d0f352b','ee76a95e512f489d9a02b219cd9afe5f','path','音乐路径','varchar(2000)','String','path','0','1','1','1','0','0','=','input','',NULL,'150','1','2016-12-17 11:30:28','1','2016-12-17 11:45:47',NULL,'0'),('3e59d381bbda4810b20272e53d9e26f6','2191a2fd805b4b00ac99a17d043f773f','user_channel_id','用户频道id','varchar(64)','String','userChannelId','0','1','1','1','1','1','=','input','',NULL,'60','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('3eec53911348453d91df535051bee8f4','757a8de6211d4f6dbe5141f20d53d870','del_flag','删除标志','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'90','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('3eef458ac6c24347bade1f3ad84c8577','33cec7d732734d40aa1cda723f398c33','actor','艺人','varchar(1000)','String','actor','0','1','1','1','1','1','=','input','',NULL,'50','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('40c9e79ec3054294980df63868854bbf','757a8de6211d4f6dbe5141f20d53d870','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'100','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('413e86e95d6842ecbca6d6602de152ec','43803e0d1b224476a13611431620309b','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','0','=','dateselect','',NULL,'60','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('416c76d2019b4f76a96d8dc3a8faf84c','f6e4dafaa72f4c509636484715f33a96','update_date','更新时间','timestamp(6)','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect',NULL,NULL,'9','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('418675ec668f44c281ac91553fd646b0','ee76a95e512f489d9a02b219cd9afe5f','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'80','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('42dbcb69b4c947a0997b44ebf88b2c43','33cec7d732734d40aa1cda723f398c33','create_by','创建者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'80','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('438e8ca6d525418c927061627fae07cd','43803e0d1b224476a13611431620309b','id','id','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('45f3c1b8ba7c470ca91b5148415fc8ec','e703b9720b584233a490deff3287b4b0','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'60','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('46090f855573433b98cee9cf03e0a6b9','6ef293fc5e904236b941a896779d78c5','user_id','用户id','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect','',NULL,'20','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('463595cc391944aea427024823107583','68ad4e53333a4b48ae3075261cf67ee1','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'190','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('46e6d8283270493687085d29efdecb05','f6e4dafaa72f4c509636484715f33a96','del_flag','删除标记（0：正常；1：删除）','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'11','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('47cba63e56e047e6b21855f5d4c1f7f6','ee76a95e512f489d9a02b219cd9afe5f','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'120','1','2016-12-17 11:30:28','1','2016-12-17 11:45:47',NULL,'0'),('47d13c678dc24a948baa560edc71a737','6ef293fc5e904236b941a896779d78c5','update_by','修改人','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'80','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('4a0013ac046b45bd9d0d3a5485d6d169','162a3efb92964941a4724ff42789da99','del_flag','删除标志0正常1删除','int(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'110','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('4a0a1fff86ca46519477d66b82e01991','aef6f1fc948f4c9ab1c1b780bc471cc2','name','名称','nvarchar2(100)','String','name','0','1','1','1','1','1','like','input',NULL,NULL,'5','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('4a3ec63c6f5f4802bb39df3ad34c3125','68ad4e53333a4b48ae3075261cf67ee1','status','状态','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'210','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('4a450440a66745eba09f1a85c4695541','162a3efb92964941a4724ff42789da99','timestep_name','时段名称','varchar(100)','String','timestepName','0','1','1','1','1','1','=','input','',NULL,'30','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('4adcf8fd9bb640f0840688d9db0a8653','ee76a95e512f489d9a02b219cd9afe5f','id','id','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('4b4c2cea37e4468c9c90e3c15dd12343','2f1e237dba2b4d41b6145fd23e4f9ba5','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'180','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('4c8ef12cb6924b9ba44048ba9913150b','43d6d5acffa14c258340ce6765e46c6f','create_date','创建时间','timestamp(6)','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect',NULL,NULL,'9','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('4d20ad0cace543318640c81653e5c669','2f1e237dba2b4d41b6145fd23e4f9ba5','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input','',NULL,'160','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('4d647947331c4880ab4ec6580c04ce0e','2f1e237dba2b4d41b6145fd23e4f9ba5','token','token','varchar(50)','String','token','0','0','1','1','0','0','=','input','',NULL,'50','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('4ff2d05bc0ba4ddb90bf1b758f83251c','68ad4e53333a4b48ae3075261cf67ee1','channel_type','频道类型','char(1)','String','channelType','0','1','1','1','1','1','=','input','theme_type',NULL,'220','1','2016-12-17 12:17:52','1','2016-12-17 13:35:11',NULL,'0'),('523caee3dab643be8cfb7ad68db0c90b','d73eaf376981483e8765be4febdb4d74','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('526c7a7c48f843b0a8ddfe0c9771e85c','acf218bf9a2f4ac297ae378a44667c5c','group_channel_id','组合频道','varchar(32)','com.cdboo.channel.entity.CdbooChannel','groupChannelId.id','0','1','1','1','0','0','=','input','',NULL,'20','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('53d65a3d306d4fac9e561db9d3c66912','6e05c389f3c6415ea34e55e9dfb28934','del_flag','删除标记（0：正常；1：删除）','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'9','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('547bb02364be417197ee6adf0f74c711','c3c293ec079d49c689f38ac82f989593','name','机构名称','varchar(64)','String','name','0','1','1','1','1','1','like','input','',NULL,'30','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('5506eacdf4474c2388d48ddb54b43013','ead88eabb0644854a2c64a80b5ad16e9','del_flag','删除标志0正常1删除','int(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'120','1','2016-12-13 10:21:42','1','2016-12-13 10:24:30',NULL,'0'),('564bf5c3962244889ab9167c94af9722','68ad4e53333a4b48ae3075261cf67ee1','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'150','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('56fa71c0bd7e4132931874e548dc9ba5','6e05c389f3c6415ea34e55e9dfb28934','update_by','更新者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input',NULL,NULL,'6','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('57a3e372184e4416a3c59c7fa9d4df09','d73eaf376981483e8765be4febdb4d74','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'110','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('57fa8f94f51841bc8a492f4d44340f91','6ef293fc5e904236b941a896779d78c5','del_flag','删除标记','char(1)','String','delFlag','0','1','1','0','0','0','=','radiobox','del_flag',NULL,'110','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('58257a6159dd451a9b720945e0ec6857','68ad4e53333a4b48ae3075261cf67ee1','channel_name','频道名称','varchar(200)','String','channelName','0','1','1','1','1','1','=','input','',NULL,'30','1','2016-12-17 12:17:51','1','2016-12-17 13:35:08',NULL,'0'),('5a4a1933c9c844fdba99de043dc8205e','aef6f1fc948f4c9ab1c1b780bc471cc2','update_by','更新者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input',NULL,NULL,'10','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('5a4f2ac6548b4571a4df7cb847bfea02','d73eaf376981483e8765be4febdb4d74','music__id','音乐','varchar(64)','String','musicId','0','1','1','1','1','0','=','input','',NULL,'60','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('5c3dbe7aae5e4bc5a257164511f38181','acf218bf9a2f4ac297ae378a44667c5c','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect','',NULL,'50','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('5d35dbea9079412689ea498120ba132c','c3c293ec079d49c689f38ac82f989593','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'80','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('5d7b31125da7490a88e47a029dab7a66','acf218bf9a2f4ac297ae378a44667c5c','create_by','创建者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'40','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('5ddf1dbd849f42e6a3ca15b0647443f1','6ef293fc5e904236b941a896779d78c5','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','0','=','dateselect','',NULL,'70','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('5e5c69bd3eaa4dcc9743f361f3771c08','aef6f1fc948f4c9ab1c1b780bc471cc2','id','编号','varchar2(64)','String','id','1','0','1','0','0','0','=','input',NULL,NULL,'1','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('5eab600c0cc3446b8b74c5839ca9e4b9','757a8de6211d4f6dbe5141f20d53d870','music_id','音乐id','varchar(64)','com.cdboo.music.entity.CdbooMusic','musicId','0','1','1','1','1','1','=','select','',NULL,'20','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('5ff4452b07c24d8f91bb86a9a09ec43f','acf218bf9a2f4ac297ae378a44667c5c','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'100','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('600a247184d84ec48b0effbc1d7ad14e','2f1e237dba2b4d41b6145fd23e4f9ba5','nickname','昵称','varchar(100)','String','nickname','0','0','1','1','1','1','=','input','',NULL,'40','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('61c68dd3182b48cf9db76d5d4fc0c6c2','d73eaf376981483e8765be4febdb4d74','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'150','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('633f5a49ec974c099158e7b3e6bfa930','f6e4dafaa72f4c509636484715f33a96','name','名称','nvarchar2(100)','String','name','0','0','1','1','1','1','like','input',NULL,NULL,'4','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('6463baf8631640d1992c006aada0fa27','68ad4e53333a4b48ae3075261cf67ee1','theme_type','风格类型','char(1)','String','themeType','0','1','1','1','1','1','=','select','theme_type',NULL,'50','1','2016-12-17 12:17:51','1','2016-12-17 13:35:08',NULL,'0'),('6508c12a6262446c9dc3664cef1bd589','ee76a95e512f489d9a02b219cd9afe5f','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'100','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('652491500f2641ffa7caf95a93e64d34','6e05c389f3c6415ea34e55e9dfb28934','update_date','更新时间','timestamp(6)','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect',NULL,NULL,'7','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('6607c233197c4b80a7c761d930fbb0b5','2f1e237dba2b4d41b6145fd23e4f9ba5','update_date','更新时间','datetime','java.util.Date','updateDate','0','0','1','1','0','0','=','dateselect','',NULL,'170','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('6763ff6dc7cd4c668e76cf9b697d3ff6','f6e4dafaa72f4c509636484715f33a96','sort','排序','number(10)','Integer','sort','0','0','1','1','1','0','=','input',NULL,NULL,'5','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('67d0331f809a48ee825602659f0778e8','43d6d5acffa14c258340ce6765e46c6f','name','名称','nvarchar2(100)','String','name','0','1','1','1','1','1','like','input',NULL,NULL,'5','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('68345713bef3445c906f70e68f55de38','6e05c389f3c6415ea34e55e9dfb28934','test_data_main_id','业务主表','varchar2(64)','String','testDataMain.id','0','1','1','1','0','0','=','input',NULL,NULL,'2','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('6c4b65f71c98477db52e78dc5940eeab','68ad4e53333a4b48ae3075261cf67ee1','voice','人声','varchar(100)','String','voice','0','1','1','1','0','1','=','select','voice_type',NULL,'110','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('71ea4bc10d274911b405f3165fc1bb1a','aef6f1fc948f4c9ab1c1b780bc471cc2','area_id','归属区域','nvarchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.Area','area.id|name','0','1','1','1','1','1','=','areaselect',NULL,NULL,'4','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('76254fe7345041d8a54d08e06595b972','d73eaf376981483e8765be4febdb4d74','end_date','结束日期','date','java.util.Date','endDate','0','1','1','1','1','0','=','dateselect','',NULL,'50','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('77c1848836da41a2b6632b98b88e3f53','d73eaf376981483e8765be4febdb4d74','insert_name','插播名称','varchar(100)','String','insertName','0','1','1','1','1','1','=','input','',NULL,'30','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('79e0891a399c4af1a7365728ca8cb1b0','d73eaf376981483e8765be4febdb4d74','user_id','用户','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect','',NULL,'160','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('79f39c1a50d94252a37a4a626f5d0c7a','43803e0d1b224476a13611431620309b','remarks','备注','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'90','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('7a1f100d42054fa68baaa285eb682662','68ad4e53333a4b48ae3075261cf67ee1','update_date','更新时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'180','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('7a7a47a00461473d9c9a5ab065c0cae2','33cec7d732734d40aa1cda723f398c33','update_by','更新者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input','',NULL,'100','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('7b7da49ed6d4490781e99d8b2f21c140','162a3efb92964941a4724ff42789da99','endtime','结束时间','time','String','endtime','0','1','1','1','1','1','between','dateselect','',NULL,'50','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('7c4740eefd264ccaba32e7e75f25cd4a','2191a2fd805b4b00ac99a17d043f773f','id','id','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('7c59a976f1ce42fe890e1544bfedd048','33cec7d732734d40aa1cda723f398c33','music_name','音乐名称','varchar(1000)','String','musicName','0','1','1','1','1','1','=','input','',NULL,'40','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('7c8a124f3e444ab68cbc56d71bc49c6d','2191a2fd805b4b00ac99a17d043f773f','user_timestep_id','用户时段id','varchar(64)','String','userTimestepId','0','1','1','1','1','1','=','input','',NULL,'50','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('7d69f702ec5d477485d2234cb4a1aaec','6ef293fc5e904236b941a896779d78c5','create_by','创建人','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','1','0','=','input','',NULL,'60','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('7e065f7e993144d281fc5c1aa5f9ee7b','2191a2fd805b4b00ac99a17d043f773f','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'110','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('7f871058d94c4d9a89084be7c9ce806d','6e05c389f3c6415ea34e55e9dfb28934','remarks','备注信息','nvarchar2(255)','String','remarks','0','1','1','1','1','0','=','input',NULL,NULL,'8','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('7f96704390cc46778f42847e89d700ab','68ad4e53333a4b48ae3075261cf67ee1','speed','速度','varchar(100)','String','speed','0','1','1','1','0','1','=','select','speed_type',NULL,'100','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('7faa6bde3f41474fb4c84803cb9040c2','33cec7d732734d40aa1cda723f398c33','remarks','备注信息','varchar(1000)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'120','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('810d1d6e386042deae17d6e355d49718','acf218bf9a2f4ac297ae378a44667c5c','remarks','备注信息','varchar(1000)','String','remarks','0','1','1','1','1','0','=','textarea','',NULL,'80','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('8147e59586a041bcadd8d7039c7b5913','2191a2fd805b4b00ac99a17d043f773f','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect','',NULL,'120','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('821e18a481bf4f279250b1213d645bb2','2f1e237dba2b4d41b6145fd23e4f9ba5','photo','用户头像','varchar(1000)','String','photo','0','1','1','1','1','1','=','input','',NULL,'100','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('822583a7470943c49c0107d8638342f2','162a3efb92964941a4724ff42789da99','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'120','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('85489778c7c748e292ed6995172c6c5b','e703b9720b584233a490deff3287b4b0','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'120','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('8776f9edc5f547759b9c7ac94980348e','68ad4e53333a4b48ae3075261cf67ee1','channel_no','频道编号','varchar(100)','String','channelNo','0','1','1','1','1','1','=','input','',NULL,'20','1','2016-12-17 12:17:51','1','2016-12-17 13:35:08',NULL,'0'),('89f14d98bfa64283a393f6237a05dc5f','d73eaf376981483e8765be4febdb4d74','number','循环次数','int(10)','String','number','0','1','1','1','1','0','=','input','',NULL,'80','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('8b48774cfe184913b8b5eb17639cf12d','43d6d5acffa14c258340ce6765e46c6f','create_by','创建者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input',NULL,NULL,'8','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('8b7cf0525519474ebe1de9e587eb7067','6e05c389f3c6415ea34e55e9dfb28934','create_date','创建时间','timestamp(6)','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect',NULL,NULL,'5','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('8b9de88df53e485d8ef461c4b1824bc1','43d6d5acffa14c258340ce6765e46c6f','user_id','归属用户','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect',NULL,NULL,'2','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('8d2cd264b5af4372afa380de24548161','d73eaf376981483e8765be4febdb4d74','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','1','0','=','input','',NULL,'90','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('8da38dbe5fe54e9bb1f9682c27fbf403','aef6f1fc948f4c9ab1c1b780bc471cc2','remarks','备注信息','nvarchar2(255)','String','remarks','0','1','1','1','1','0','=','textarea',NULL,NULL,'12','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('90e2caa0662d4786bc7b915366d2a4bd','33cec7d732734d40aa1cda723f398c33','update_date','更新时间','datetime','java.util.Date','updateDate','0','0','1','1','0','0','=','dateselect','',NULL,'110','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('91cb5fb121034782834da47364a09166','2f1e237dba2b4d41b6145fd23e4f9ba5','login_name','登录名','varchar(100)','String','loginName','0','0','1','1','1','1','=','input','',NULL,'20','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('92481c16a0b94b0e8bba16c3c54eb1e4','f6e4dafaa72f4c509636484715f33a96','create_date','创建时间','timestamp(6)','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect',NULL,NULL,'7','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('92adb514a2b148be9bf6a3134e31b482','acf218bf9a2f4ac297ae378a44667c5c','update_by','更新者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input','',NULL,'60','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('930ee10e38c74772abb554ae13be4168','ead88eabb0644854a2c64a80b5ad16e9','hierarchy','所在层级','int(10)','String','hierarchy','0','1','1','1','0','0','=','input','',NULL,'50','1','2016-12-13 10:21:41','1','2016-12-13 10:24:29',NULL,'0'),('953b951a760444229510d146fc71c3b0','c3c293ec079d49c689f38ac82f989593','id','机构ID','varchar(64)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('9733989e89d244b6af812d986a2cd9f9','43803e0d1b224476a13611431620309b','update_date','修改时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'80','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('98d0ec8f02704a3ab8c182ed31a1fade','ead88eabb0644854a2c64a80b5ad16e9','create_by','创建者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'70','1','2016-12-13 10:21:41','1','2016-12-13 10:24:29',NULL,'0'),('9a012c1d2f934dbf996679adb7cc827a','f6e4dafaa72f4c509636484715f33a96','parent_id','父级编号','varchar2(64)','This','parent.id|name','0','0','1','1','0','0','=','treeselect',NULL,NULL,'2','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('9b663367a901452e8bc1bec744b45be6','e703b9720b584233a490deff3287b4b0','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect','',NULL,'70','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('9ccda75c5cc448d9b079542467241a38','68ad4e53333a4b48ae3075261cf67ee1','emotion','情绪','varchar(100)','String','emotion','0','1','1','1','0','1','=','select','emotion_type',NULL,'130','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('9d5eacb7bc0d4e70adcf61afd6d2158a','e703b9720b584233a490deff3287b4b0','service_note','服务说明','longtext','String','serviceNote','0','1','1','1','0','0','=','input','',NULL,'50','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('9ec98fb29dba456e96c66e5a36c9a9f7','162a3efb92964941a4724ff42789da99','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-13 11:21:55','1','2016-12-13 11:21:55',NULL,'0'),('9eda8352c98341c08e77c8bf18a21560','162a3efb92964941a4724ff42789da99','update_by','更新者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input','',NULL,'80','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('a1f91f03045649be9dcc08d1cd9718fe','2f1e237dba2b4d41b6145fd23e4f9ba5','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'140','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('a226c0da0f4b4848a52d18818d82d5f6','757a8de6211d4f6dbe5141f20d53d870','user_id','用户id','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','select','',NULL,'30','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('a23c22b192f349ea8f343d818f703df9','d73eaf376981483e8765be4febdb4d74','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','1','0','=','dateselect','',NULL,'100','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('a259821fdabb4226ae10f93ada888d43','c3c293ec079d49c689f38ac82f989593','no','机构编号','varchar(64)','String','no','0','1','1','1','1','1','like','input','',NULL,'20','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('a59f7930d8134f72bafbedf8bd0cf639','68ad4e53333a4b48ae3075261cf67ee1','element','元素','varchar(100)','String','element','0','1','1','1','0','1','=','select','element_type',NULL,'120','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('a96f175daf424808bfc2a88c554facbc','2191a2fd805b4b00ac99a17d043f773f','start_date','开始日期','date','java.util.Date','startDate','0','1','1','1','1','0','=','dateselect','',NULL,'90','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('a9c615da3294442c8832482d2eb54116','2f1e237dba2b4d41b6145fd23e4f9ba5','password','密码','varchar(100)','String','password','0','0','1','1','0','0','=','input','',NULL,'30','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('aab3518bc39645dd9bc615a8f80e8f98','e703b9720b584233a490deff3287b4b0','contract_end_time','合同结束时间','datetime','java.util.Date','contractEndTime','0','1','1','1','1','0','=','dateselect','',NULL,'40','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('abc2e5d3f9944dd099b7b4e3083e65ba','43803e0d1b224476a13611431620309b','user_id','用户id','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect','',NULL,'20','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('ac51332940a544a18d1a860329c220de','162a3efb92964941a4724ff42789da99','create_by','创建者','varchar(100)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','0','0','=','input','',NULL,'60','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('ac9c522f07b34c879478c75e7675b365','c3c293ec079d49c689f38ac82f989593','create_by','创建者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','1','1','0','0','0','=','input','',NULL,'60','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('ad3bf0d4b44b4528a5211a66af88f322','aef6f1fc948f4c9ab1c1b780bc471cc2','office_id','归属部门','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.Office','office.id|name','0','1','1','1','1','1','=','officeselect',NULL,NULL,'3','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('add4b0934cd7484b9405959e06e8ea3a','68ad4e53333a4b48ae3075261cf67ee1','theme_concrete_type','风格类型明细','char(2)','String','themeConcreteType','0','1','1','1','1','1','=','select','',NULL,'60','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('aee45e44e2154b79a961bf477e35c235','d73eaf376981483e8765be4febdb4d74','start_date','开始日期','date','java.util.Date','startDate','0','1','1','1','1','0','=','dateselect','',NULL,'40','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('af2b10762b41435da3ee1f4e73f4a106','2191a2fd805b4b00ac99a17d043f773f','plan_no','计划编号','varchar(100)','String','planNo','0','1','1','1','1','1','=','input','',NULL,'20','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('af2b427558e74f0995d1a3ace9695f44','43803e0d1b224476a13611431620309b','create_by','创建人','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','createBy.id','0','0','1','0','1','0','=','input','',NULL,'50','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('afd1a9e30fd74e70852192dd0493bfba','ee76a95e512f489d9a02b219cd9afe5f','music_name','音乐名称','varchar(100)','String','musicName','0','1','1','1','1','1','=','input','',NULL,'40','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('b83536c4024c4944aed66d30473f2eff','2191a2fd805b4b00ac99a17d043f773f','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'170','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('ba8055d118bb4cef8e96d3af88dbdb68','e703b9720b584233a490deff3287b4b0','user_id','用户id','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','user.id|name','0','1','1','1','1','1','=','userselect','',NULL,'20','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('bb1256a8d1b741f6936d8fed06f45eed','f6e4dafaa72f4c509636484715f33a96','update_by','更新者','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.User','updateBy.id','0','0','1','1','0','0','=','input',NULL,NULL,'8','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('c00ad19b9a574069a35bb8d78d45e7b3','2f1e237dba2b4d41b6145fd23e4f9ba5','user_type','用户类型','char(1)','String','userType','0','1','1','1','0','0','=','input','',NULL,'90','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('c07ce3f1511842ef919537e7e8ff7502','2f1e237dba2b4d41b6145fd23e4f9ba5','login_date','最后登陆时间','datetime','java.util.Date','loginDate','0','1','1','1','1','1','=','dateselect','',NULL,'120','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('c11502d5eed14190bf3aa753450683be','ead88eabb0644854a2c64a80b5ad16e9','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'130','1','2016-12-13 10:21:43','1','2016-12-13 10:24:30',NULL,'0'),('c1b82c3d118c411fabacf1c4f71d23de','33cec7d732734d40aa1cda723f398c33','status','状态位显示','int(1)','String','status','0','1','1','1','0','0','=','input','',NULL,'140','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('c3ef049e646547738b2387fb0f3d2935','ead88eabb0644854a2c64a80b5ad16e9','parent_id','父级编号','varchar(32)','This','parent.id|name','0','1','1','1','0','0','=','treeselect','',NULL,'20','1','2016-12-13 10:21:40','1','2016-12-13 10:24:28',NULL,'0'),('c66e9cf0847d4873a498334c93c6db73','ee76a95e512f489d9a02b219cd9afe5f','actor','艺人','varchar(100)','String','actor','0','1','1','1','1','1','=','input','',NULL,'50','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('c684c479a23f488fa6f6b8dec3989acc','757a8de6211d4f6dbe5141f20d53d870','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'60','1','2016-12-21 15:16:51','1','2016-12-21 15:17:01',NULL,'0'),('c6881470b36b478ca02035ff53c5a46c','acf218bf9a2f4ac297ae378a44667c5c','del_flag','删除标志','int(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'90','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('ca68a2d403f0449cbaa1d54198c6f350','43d6d5acffa14c258340ce6765e46c6f','office_id','归属部门','varchar2(64)','com.thinkgem.jeesite.modules.modules.sys.entity.Office','office.id|name','0','1','1','1','0','0','=','officeselect',NULL,NULL,'3','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('cb9c0ec3da26432d9cbac05ede0fd1d0','43d6d5acffa14c258340ce6765e46c6f','remarks','备注信息','nvarchar2(255)','String','remarks','0','1','1','1','1','0','=','textarea',NULL,NULL,'12','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('cc15b79ed04848959bfe5bacc525bada','6ef293fc5e904236b941a896779d78c5','remarks','备注','varchar(255)','String','remarks','0','1','1','1','0','0','=','textarea','',NULL,'100','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('cd6b7d31656449258f097a146258342a','6ef293fc5e904236b941a896779d78c5','end_time','结束时间','time','String','endTime','0','1','1','1','1','0','=','input','',NULL,'50','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('ce96ef014abe4622a65c01436a35936a','ead88eabb0644854a2c64a80b5ad16e9','name','名称','varchar(1000)','String','name','0','1','1','1','1','1','like','input','',NULL,'40','1','2016-12-13 10:21:41','1','2016-12-13 10:24:28',NULL,'0'),('ced0c8f6d36546efb140fd790f3429e0','ead88eabb0644854a2c64a80b5ad16e9','sort','排序','int(10)','String','sort','0','1','1','1','0','0','=','input','',NULL,'60','1','2016-12-13 10:21:41','1','2016-12-13 10:24:29',NULL,'0'),('cfcfa06ea61749c9b4c4dbc507e0e580','f6e4dafaa72f4c509636484715f33a96','id','编号','varchar2(64)','String','id','1','0','1','0','0','0','=','input',NULL,NULL,'1','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('d02ff09e88594b15b3561e47801d945c','43803e0d1b224476a13611431620309b','update_by','修改人','varchar(255)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'70','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('d0a0f5defa0d4e33a7ba77447d289e70','d73eaf376981483e8765be4febdb4d74','del_flag','删除标志','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'140','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0'),('d2ed1a3dab954aada0352a1d0fb4bc12','2f1e237dba2b4d41b6145fd23e4f9ba5','login_ip','最后登陆IP','varchar(100)','String','loginIp','0','1','1','1','1','1','=','input','',NULL,'110','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('d49532f66efd4e3f828058175e6db1d5','e703b9720b584233a490deff3287b4b0','contract_start_time','合同开始时间','datetime','java.util.Date','contractStartTime','0','1','1','1','1','0','=','dateselect','',NULL,'30','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('d5c2d932ae904aa8a9f9ef34cd36fb0b','43d6d5acffa14c258340ce6765e46c6f','sex','性别','char(1)','String','sex','0','1','1','1','0','1','=','select','sex',NULL,'6','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('d5cdb697085f4c81842586fd46b8a1f3','e703b9720b584233a490deff3287b4b0','update_by','更新者','varchar(64)','com.thinkgem.jeesite.modules.sys.entity.User','updateBy.id','0','1','1','1','0','0','=','input','',NULL,'80','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('d680e5c5165c440589f9a084a805ad82','162a3efb92964941a4724ff42789da99','remarks','备注信息','varchar(1000)','String','remarks','0','1','1','1','1','0','=','textarea','',NULL,'100','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('d7261a9b3dde459f892c3bdca00dc68d','2191a2fd805b4b00ac99a17d043f773f','remarks','备注信息','varchar(255)','String','remarks','0','1','1','1','1','0','=','textarea','',NULL,'150','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('d7bc8f3539c7472cbd8889662e8bbdb1','68ad4e53333a4b48ae3075261cf67ee1','channel_version','频道版本','varchar(100)','String','channelVersion','0','1','1','1','1','1','=','input','',NULL,'70','1','2016-12-17 12:17:52','1','2016-12-17 13:35:09',NULL,'0'),('d9684763c5544ce697f8dad187b9cd6b','2191a2fd805b4b00ac99a17d043f773f','end_date','结束日期','date','java.util.Date','endDate','0','1','1','1','1','0','=','dateselect','',NULL,'100','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('deb0c611a89f4062ae7424fe8680c70e','2191a2fd805b4b00ac99a17d043f773f','update_date','更新时间','datetime','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect','',NULL,'140','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('deb11bea2cc342f081acf44058104bc2','c3c293ec079d49c689f38ac82f989593','type','机构类型','varchar(64)','String','type','0','1','1','1','1','1','=','select','unit_type',NULL,'40','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('e101033d69cb4da092dc84345abb5aa5','ead88eabb0644854a2c64a80b5ad16e9','parent_ids','所有父级编号','varchar(2000)','String','parentIds','0','1','1','1','0','0','like','input','',NULL,'30','1','2016-12-13 10:21:41','1','2016-12-13 10:24:28',NULL,'0'),('e26c1c51d4604a91b61b4e495817ddcb','2191a2fd805b4b00ac99a17d043f773f','del_flag','删除标志','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'160','1','2016-12-21 15:01:44','1','2016-12-21 15:01:56',NULL,'0'),('e3820ed34a1248a598b8238dd391e4e5','c3c293ec079d49c689f38ac82f989593','create_date','创建时间','datetime','java.util.Date','createDate','0','1','1','0','1','1','between','dateselect','',NULL,'70','1','2016-06-07 10:00:13','1','2016-06-07 10:00:13',NULL,'1'),('e4662d87be4a44219076496505fa5964','6ef293fc5e904236b941a896779d78c5','name','时段名称','varchar(64)','String','name','0','1','1','1','1','1','like','input','',NULL,'30','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('e4e00276e15b45f5b2602cf9e3d7662e','33cec7d732734d40aa1cda723f398c33','special','专辑','varchar(1000)','String','special','0','1','1','1','1','1','=','input','',NULL,'60','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('e64050a2ebf041faa16f12dda5dcf784','6e05c389f3c6415ea34e55e9dfb28934','name','名称','nvarchar2(100)','String','name','0','1','1','1','1','1','like','input',NULL,NULL,'3','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('e6943350bcf74f859c918f69cbb5d743','162a3efb92964941a4724ff42789da99','update_date','更新时间','datetime','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect','',NULL,'90','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('e7058dda6dd24069bfc4d1dfec85ca2a','2f1e237dba2b4d41b6145fd23e4f9ba5','login_flag','是否可登录','varchar(64)','String','loginFlag','0','1','1','1','0','0','=','input','',NULL,'130','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('e797ce2a853d4e76b3496dcb761f9413','e703b9720b584233a490deff3287b4b0','del_flag','删除标志','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'110','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('e8d11127952d4aa288bb3901fc83127f','43d6d5acffa14c258340ce6765e46c6f','del_flag','删除标记（0：正常；1：删除）','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'13','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('ea261c2a17734541b723ac636a6d784b','43803e0d1b224476a13611431620309b','del_flag','删除标记','char(1)','String','delFlag','0','1','1','0','0','0','=','radiobox','del_flag',NULL,'100','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('ea68bc64e36a49679c629fad69f812cb','68ad4e53333a4b48ae3075261cf67ee1','instrument','乐器','varchar(100)','String','instrument','0','1','1','1','0','1','=','select','instrument_type',NULL,'140','1','2016-12-17 12:17:52','1','2016-12-17 13:35:10',NULL,'0'),('eb2e5afd13f147a990d30e68e7f64e12','aef6f1fc948f4c9ab1c1b780bc471cc2','update_date','更新时间','timestamp(6)','java.util.Date','updateDate','0','0','1','1','1','0','=','dateselect',NULL,NULL,'11','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('edb40e6163ab49f186ae90d4fe0538f7','ee76a95e512f489d9a02b219cd9afe5f','music_no','音乐编号','varchar(100)','String','musicNo','0','1','1','1','0','0','=','input','',NULL,'20','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('ee4b566cbdc4457c89244ee1072b0241','33cec7d732734d40aa1cda723f398c33','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('ef404d4da0bf4914a9eb48062cde3438','ead88eabb0644854a2c64a80b5ad16e9','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect','',NULL,'80','1','2016-12-13 10:21:42','1','2016-12-13 10:24:29',NULL,'0'),('f0697c11c3424037bbd64afab92aaf36','33cec7d732734d40aa1cda723f398c33','volume','音量','varchar(1000)','String','volume','0','1','1','1','1','0','=','input','',NULL,'70','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('f2ba455eb1394eccbae4fe709e715ce8','ee76a95e512f489d9a02b219cd9afe5f','music_owner','音乐拥有者类型','char(1)','String','musicOwner','0','1','1','1','1','1','=','input','owner_type',NULL,'30','1','2016-12-17 11:30:28','1','2016-12-17 11:45:46',NULL,'0'),('f5ed8c82bad0413fbfcccefa95931358','f6e4dafaa72f4c509636484715f33a96','remarks','备注信息','nvarchar2(255)','String','remarks','0','1','1','1','1','0','=','textarea',NULL,NULL,'10','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05',NULL,'0'),('f6d916452c2a4ae994c2f71f1b60a23b','33cec7d732734d40aa1cda723f398c33','del_flag','删除标志0正常1删除','int(1)','String','delFlag','0','0','1','0','1','1','=','select','del_flag',NULL,'130','1','2016-12-13 10:40:29','1','2016-12-13 10:41:18',NULL,'1'),('f715ac8840354b0d9cf3b4714f5a15b8','162a3efb92964941a4724ff42789da99','create_date','创建时间','datetime','java.util.Date','createDate','0','0','1','0','0','0','=','dateselect','',NULL,'70','1','2016-12-13 11:21:56','1','2016-12-13 11:21:56',NULL,'0'),('f7ce34a54a814e49927cbbae44252d3c','e703b9720b584233a490deff3287b4b0','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-21 15:25:59','1','2016-12-21 15:25:59',NULL,'0'),('f7f194cc04f44d09afb23b6380644d4c','6ef293fc5e904236b941a896779d78c5','start_time','开始时间','time','String','startTime','0','1','1','1','1','0','=','input','',NULL,'40','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('f80f91837bb94b72a7f6db6c7a6dddba','6ef293fc5e904236b941a896779d78c5','update_date','修改时间','datetime','java.util.Date','updateDate','0','1','1','1','0','0','=','dateselect','',NULL,'90','1','2016-12-21 15:27:09','1','2016-12-21 15:27:09',NULL,'0'),('fa4730f72a44418281e13d834cac6007','43803e0d1b224476a13611431620309b','channel_id','频道id','varchar(64)','com.cdboo.channel.entity.CdbooChannel','channel.id|channelName','0','1','1','1','1','1','=','select','',NULL,'30','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('fb7f9bd7131f49eaa3b41b84d21e964c','acf218bf9a2f4ac297ae378a44667c5c','id','id','varchar(32)','String','id','1','0','1','0','0','0','=','input','',NULL,'10','1','2016-12-29 11:55:08','1','2016-12-29 11:55:08',NULL,'0'),('fc1bedefdb9941edb7099172ea107e0a','43803e0d1b224476a13611431620309b','music_id','音乐id','varchar(64)','com.cdboo.music.entity.CdbooMusic','music.id|musicName','0','1','1','1','1','1','=','select','',NULL,'40','1','2016-12-21 15:20:32','1','2016-12-21 15:20:32',NULL,'0'),('fde2f8d786de497dacf45b307b44d497','33cec7d732734d40aa1cda723f398c33','music_owner','音乐拥有者类型','varchar(100)','String','musicOwner','0','1','1','1','1','1','=','select','owner_type',NULL,'30','1','2016-12-13 10:40:28','1','2016-12-13 10:41:18',NULL,'1'),('ffba67de31414fdb8e4ef7b425f545b4','ee76a95e512f489d9a02b219cd9afe5f','del_flag','删除标志','char(1)','String','delFlag','0','0','1','0','0','0','=','radiobox','del_flag',NULL,'130','1','2016-12-17 11:30:28','1','2016-12-17 11:45:47',NULL,'0'),('ffc3468a805740afb4c286c4b92b132e','2f1e237dba2b4d41b6145fd23e4f9ba5','mobile','手机','varchar(200)','String','mobile','0','1','1','1','0','0','=','input','',NULL,'80','1','2016-11-24 13:26:24','1','2016-12-28 13:53:35',NULL,'0'),('ffd0c86293d84055852bb5669415b5c5','d73eaf376981483e8765be4febdb4d74','time','时间点','time','String','time','0','1','1','1','1','0','=','input','',NULL,'70','1','2016-12-21 15:06:53','1','2016-12-21 15:07:13',NULL,'0');

/*Table structure for table `gen_template` */

DROP TABLE IF EXISTS `gen_template`;

CREATE TABLE `gen_template` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '分类',
  `file_path` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '生成文件路径',
  `file_name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '生成文件名',
  `content` text COLLATE utf8_bin COMMENT '内容',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记（0：正常；1：删除）',
  PRIMARY KEY (`id`),
  KEY `gen_template_del_falg` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='代码模板表';

/*Data for the table `gen_template` */

/*Table structure for table `oa_leave` */

DROP TABLE IF EXISTS `oa_leave`;

CREATE TABLE `oa_leave` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `process_instance_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例编号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `leave_type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '请假类型',
  `reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请假理由',
  `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
  `reality_start_time` datetime DEFAULT NULL COMMENT '实际开始时间',
  `reality_end_time` datetime DEFAULT NULL COMMENT '实际结束时间',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_leave_create_by` (`create_by`),
  KEY `oa_leave_process_instance_id` (`process_instance_id`),
  KEY `oa_leave_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='请假流程表';

/*Data for the table `oa_leave` */

/*Table structure for table `oa_notify` */

DROP TABLE IF EXISTS `oa_notify`;

CREATE TABLE `oa_notify` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `title` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `status` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='通知通告';

/*Data for the table `oa_notify` */

insert  into `oa_notify`(`id`,`type`,`title`,`content`,`files`,`status`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('8e51510759e941aeb8becc6b1b79a454','2','555','5555','','1','1','2016-06-02 09:58:14','1','2016-06-02 09:58:14',NULL,'0');

/*Table structure for table `oa_notify_record` */

DROP TABLE IF EXISTS `oa_notify_record`;

CREATE TABLE `oa_notify_record` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `oa_notify_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '通知通告ID',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '接受人',
  `read_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`oa_notify_id`),
  KEY `oa_notify_record_user_id` (`user_id`),
  KEY `oa_notify_record_read_flag` (`read_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='通知通告发送记录';

/*Data for the table `oa_notify_record` */

insert  into `oa_notify_record`(`id`,`oa_notify_id`,`user_id`,`read_flag`,`read_date`) values ('303f0f2c4e5747fe8403598eeb983c81','8e51510759e941aeb8becc6b1b79a454','1','1','2016-06-02');

/*Table structure for table `oa_test_audit` */

DROP TABLE IF EXISTS `oa_test_audit`;

CREATE TABLE `oa_test_audit` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `PROC_INS_ID` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `USER_ID` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '变动用户',
  `OFFICE_ID` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属部门',
  `POST` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '岗位',
  `AGE` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `EDU` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '学历',
  `CONTENT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整原因',
  `OLDA` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '现行标准 薪酬档级',
  `OLDB` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '现行标准 月工资额',
  `OLDC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '现行标准 年薪总额',
  `NEWA` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整后标准 薪酬档级',
  `NEWB` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整后标准 月工资额',
  `NEWC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '调整后标准 年薪总额',
  `ADD_NUM` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '月增资',
  `EXE_DATE` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '执行时间',
  `HR_TEXT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '人力资源部门意见',
  `LEAD_TEXT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '分管领导意见',
  `MAIN_LEAD_TEXT` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '集团主要领导意见',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `OA_TEST_AUDIT_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='审批流程测试表';

/*Data for the table `oa_test_audit` */

/*Table structure for table `sys_area` */

DROP TABLE IF EXISTS `sys_area`;

CREATE TABLE `sys_area` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';

/*Data for the table `sys_area` */

insert  into `sys_area`(`id`,`parent_id`,`parent_ids`,`name`,`sort`,`code`,`type`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('1','0','0,','中国','10','100000','1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2','1','0,1,','吉林省','20','220000','2','1','2013-05-27 08:00:00','1','2016-10-08 11:30:57','','0'),('3','2','0,1,2,','长春市','30','220100','3','1','2013-05-27 08:00:00','1','2016-10-08 11:32:00','','0'),('4','3','0,1,2,3,','市辖区','40','220101','4','1','2013-05-27 08:00:00','1','2016-10-08 11:35:21','','0'),('4429c7983e3c4728b1d853dc97c2420d','ee866e39f5a343ee8ba33b3a0594e211','0,1,ee866e39f5a343ee8ba33b3a0594e211,','沈阳市','30','210100','3','1','2016-10-08 11:34:01','1','2016-10-08 11:34:01','','0'),('5','3','0,1,2,3,','历下区','50','110104','4','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('6','3','0,1,2,3,','高新区','60','110105','4','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('d060e866ff3a4fd6a7752e809df48804','4429c7983e3c4728b1d853dc97c2420d','0,1,ee866e39f5a343ee8ba33b3a0594e211,4429c7983e3c4728b1d853dc97c2420d,','和平区','30','210102','4','1','2016-10-08 11:36:16','1','2016-10-08 11:36:16','','0'),('ee866e39f5a343ee8ba33b3a0594e211','1','0,1,','辽宁省','30','210000','2','1','2016-10-08 11:31:36','1','2016-10-08 11:33:34','','0');

/*Table structure for table `sys_dict` */

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `value` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `label` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `type` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `sort` decimal(10,0) NOT NULL COMMENT '排序（升序）',
  `parent_id` varchar(64) COLLATE utf8_bin DEFAULT '0' COMMENT '父级编号',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';

/*Data for the table `sys_dict` */

insert  into `sys_dict`(`id`,`value`,`label`,`type`,`description`,`sort`,`parent_id`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('03d9c9d392e84c7e8c46f7796a9e01b1','3','大厅','unit_type','终端机构类型','40','0','1','2016-06-07 09:57:05','1','2016-06-07 09:57:28','','0'),('0414182e5e554f239d12c21f5253edae','6','儿童节','holiday_type','儿童节','70','0','1','2016-12-17 13:15:30','1','2016-12-17 13:15:30','','0'),('0512dc6b1d584d81b490e426918289d4','1','春节','holiday_type','春节','20','0','1','2016-12-17 13:14:02','1','2016-12-17 13:14:02','','0'),('0791c4e8c0ad41168853c0c1c582d045','17','慵懒','element_type','慵懒','80','0','1','2016-12-17 13:01:00','1','2016-12-27 12:00:10','','0'),('1','0','正常','del_flag','删除标记','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('10','yellow','黄色','color','颜色值','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('100','java.util.Date','Date','gen_java_type','Java类型\0\0','50','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('101','com.thinkgem.jeesite.modules.sys.entity.User','User','gen_java_type','Java类型\0\0','60','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('102','com.thinkgem.jeesite.modules.sys.entity.Office','Office','gen_java_type','Java类型\0\0','70','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('103','com.thinkgem.jeesite.modules.sys.entity.Area','Area','gen_java_type','Java类型\0\0','80','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('104','Custom','Custom','gen_java_type','Java类型\0\0','90','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('105','1','会议通告\0\0\0\0','oa_notify_type','通知通告类型','10','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('106','2','奖惩通告\0\0\0\0','oa_notify_type','通知通告类型','20','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('107','3','活动通告\0\0\0\0','oa_notify_type','通知通告类型','30','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('108','0','草稿','oa_notify_status','通知通告状态','10','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('109','1','发布','oa_notify_status','通知通告状态','20','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('11','orange','橙色','color','颜色值','50','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('110','0','未读','oa_notify_read','通知通告状态','10','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('111','1','已读','oa_notify_read','通知通告状态','20','0','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('12','default','默认主题','theme','主题方案','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('13','cerulean','天蓝主题','theme','主题方案','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('13b03f0a6b9e41c7b44d943b5dc15766','3','发布中','notice_status','消息状态发布中','30','0','1','2016-10-11 22:00:05','1','2016-10-11 22:00:25','已经发布，并且没有播放完成的。播放完成后修改为&ldquo;未发布&rdquo;状态。不可编辑，不可删除。','0'),('14','readable','橙色主题','theme','主题方案','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('15','united','红色主题','theme','主题方案','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('15b4d51c46b444a1ba4fc388e9a7592f','10','性感','element_type','性感','10','0','1','2016-12-17 12:59:02','1','2016-12-27 11:59:42','','0'),('16','flat','Flat主题','theme','主题方案','60','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('16ff58fd879a45bc9bbe63b2b11ac107','1','组合频道','channel_type','组合频道','20','0','1','2016-12-17 13:27:09','1','2016-12-17 13:27:09','','0'),('17','1','国家','sys_area_type','区域类型','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('18','2','省份、直辖市','sys_area_type','区域类型','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('1873c03d8d744a78879edb787eebfda0','3','策略中','program_status','节目状态','20','0','1','2016-06-06 15:44:49','1','2016-10-24 16:05:16','','0'),('19','3','地市','sys_area_type','区域类型','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2','1','删除','del_flag','删除标记','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('20','4','区县','sys_area_type','区域类型','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('21','1','公司','sys_office_type','机构类型','60','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('216e60a071e0428d897d209ee315d64f','7','星期日','week','星期日','70','0','1','2016-12-22 14:34:56','1','2016-12-22 14:34:56','','0'),('22','2','部门','sys_office_type','机构类型','70','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('222c71c5e849432ab8f152dcd35e8d3f','17','小提琴','instrument_type','小提琴','80','0','1','2016-12-17 13:10:30','1','2016-12-27 11:59:21','','0'),('23','3','小组','sys_office_type','机构类型','80','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('23cf389460bf4c7a85e054749eb5edaf','2','播放中','terminal_status','终端播放中','20','0','1','2016-10-11 22:20:07','1','2016-10-11 22:20:07','节目在播放中','0'),('24','4','其它','sys_office_type','机构类型','90','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('25','1','综合部','sys_office_common','快捷通用部门','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('25cefa4a99f64e728fc8960b0bfc58de','8','雪天','season_type','雪天','90','0','1','2016-12-29 09:53:38','1','2016-12-29 09:53:38','','0'),('26','2','开发部','sys_office_common','快捷通用部门','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('27','3','人力部','sys_office_common','快捷通用部门','50','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('28','1','一级','sys_office_grade','机构等级','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('284ef1a027724116be26c21b132ead51','5','星期五','week','星期五','50','0','1','2016-12-22 14:34:28','1','2016-12-22 14:34:28','','0'),('29','2','二级','sys_office_grade','机构等级','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2b41b53f67ba42d6a7b90792b627ad27','13','舒适','emotion_type','舒适','140','0','1','2016-12-17 13:06:50','1','2016-12-17 13:06:50','','0'),('2b834b11b2ae4c10b7c5698215801ba6','3','已发布','programStrategyType','节目策略类型','30','0','1','2016-10-18 15:33:04','1','2016-10-21 16:43:11','','0'),('2bdd1f7b5baf4665b4b471e9b5c9fdc4','3','愚人节','holiday_type','愚人节','40','0','1','2016-12-17 13:14:38','1','2016-12-17 13:14:38','','0'),('2e6a5d7f21474445b9411c1fd930cb1f','1','空闲中','terminal_status','终端空闲中','10','0','1','2016-10-11 22:19:40','1','2016-10-11 22:19:40','没有节目在播放','0'),('3','1','显示','show_hide','显示/隐藏','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('30','3','三级','sys_office_grade','机构等级','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('31','4','四级','sys_office_grade','机构等级','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('31e740e8f4944d1b9a5ccda950b8c809','6','星期六','week','星期六','60','0','1','2016-12-22 14:34:42','1','2016-12-22 14:34:42','','0'),('32','1','所有数据','sys_data_scope','数据范围','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3289ff839dd14a32a63566545d7a1a54','24','跳跃','emotion_type','跳跃','100','0','1','2016-12-17 13:05:46','1','2016-12-27 11:57:02','','0'),('33','2','所在公司及以下数据','sys_data_scope','数据范围','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('34','3','所在公司数据','sys_data_scope','数据范围','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('35','4','所在部门及以下数据','sys_data_scope','数据范围','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('36','5','所在部门数据','sys_data_scope','数据范围','50','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('366f02f0ffc146e1963f0e40346684cc','14','爵士鼓','instrument_type','爵士鼓','50','0','1','2016-12-17 13:09:22','1','2016-12-27 11:59:09','','0'),('36aac664505449a988219e662e448412','18','优雅','emotion_type','优雅','40','0','1','2016-12-17 13:03:45','1','2016-12-27 11:56:32','','0'),('37','8','仅本人数据','sys_data_scope','数据范围','90','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('371701c69e5d49068c35b286b910db97','16','摇滚','music_style','摇滚风格','20','0','1','2016-12-17 12:46:35','1','2016-12-27 11:54:03','','0'),('37745e4ee06c4176a03bb41e83a4bb87','3','关闭中','terminal_status','终端关闭中','30','0','1','2016-10-11 22:20:45','1','2016-10-11 22:21:04','服务器和终端不能建立连接','0'),('38','9','按明细设置','sys_data_scope','数据范围','100','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('39','1','系统管理','sys_user_type','用户类型','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3b786531b92a4d8aa73a22d71d7315cd','11','抒情','emotion_type','抒情','120','0','1','2016-12-17 13:06:18','1','2016-12-17 13:06:18','','0'),('3d5e14ebe5974c32aae30722bc49a7f8','image','图片模板','template_type','模板类型','30','0','1','2016-10-19 10:36:22','1','2016-10-19 10:36:22','','0'),('3e637e3fbd564c2086cfd2f18bec7cd1','11','摇滚','element_type','摇滚','20','0','1','2016-12-17 12:59:17','1','2016-12-27 11:59:45','','0'),('3fde5f1e87aa41bf87c57a510fca31d0','14','空灵','element_type','空灵','50','0','1','2016-12-17 13:00:06','1','2016-12-27 11:59:58','','0'),('4','0','隐藏','show_hide','显示/隐藏','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('40','2','部门经理','sys_user_type','用户类型','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('41','3','普通用户','sys_user_type','用户类型','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('42','basic','基础主题','cms_theme','站点主题','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('43','blue','蓝色主题','cms_theme','站点主题','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('44','red','红色主题','cms_theme','站点主题','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('44847c5cc81042e59d14e5be869342ec','0','未知','unit_type','终端机构类型','10','0','1','2016-06-07 09:55:56','1','2016-06-07 09:57:37','终端摆放位置','0'),('45','article','文章模型','cms_module','栏目模型','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('46','picture','图片模型','cms_module','栏目模型','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('463cee20b764426785ca46e94adb5232','0','春天','season_type','春天','10','0','1','2016-12-17 13:16:28','1','2016-12-17 13:16:28','','0'),('47','download','下载模型','cms_module','栏目模型','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('470c0d6042914df4b758f9cf175ba814','5','文学主题','style_type','文学主题','60','0','1','2016-12-29 09:58:06','1','2016-12-29 09:58:06','','0'),('476ad3daf9dc4937963b5e977780d03e','2','购物中心','site_type','购物中心场所','30','0','1','2016-12-17 12:54:51','1','2016-12-17 12:54:51','','0'),('48','link','链接模型','cms_module','栏目模型','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('4875b11a0ec24aaa93e5554a82a164a5','1','女生','voice_type','女生','20','0','1','2016-12-17 12:57:58','1','2016-12-17 12:57:58','','0'),('48f3757317274d2a93dfe540e5d45427','18','乡村','music_style','乡村风格','40','0','1','2016-12-17 12:47:35','1','2016-12-27 11:54:15','','0'),('49','special','专题模型','cms_module','栏目模型','50','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('4da64bc9772d47808d9baa10ae2306cb','15','小打','instrument_type','小打','60','0','1','2016-12-17 13:10:00','1','2016-12-27 11:59:14','','0'),('5','1','是','yes_no','是/否','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('50','0','默认展现方式','cms_show_modes','展现方式','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5011ab84df9a4d128ab193627452e4a5','1','稍慢','speed_type','稍慢速','20','0','1','2016-12-17 12:55:46','1','2016-12-17 12:55:46','','0'),('502a2540ac7c4ac4b11ffa02c662031c','1','待提交','programStrategyType','节目策略类型','10','0','1','2016-10-18 15:32:28','1','2016-10-21 16:43:03','','0'),('51','1','首栏目内容列表','cms_show_modes','展现方式','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('52','2','栏目第一条内容','cms_show_modes','展现方式','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('53','0','发布','cms_del_flag','内容状态','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('54','1','删除','cms_del_flag','内容状态','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('55','2','审核','cms_del_flag','内容状态','15','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5554b982da704f27a3c38af1ac3fdc42','12','电吉他','instrument_type','电吉他','30','0','1','2016-12-17 13:08:19','1','2016-12-27 11:58:55','','0'),('56','1','首页焦点图','cms_posid','推荐位','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('57','2','栏目页文章推荐','cms_posid','推荐位','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5749ede903584ebcbaff3ffe37de36da','2','星期二','week','星期二','20','0','1','2016-12-22 14:32:04','1','2016-12-22 14:32:04','','0'),('57e453d968fb4854bd7f14ae248985a6','0','茶馆','site_type','茶馆场所','10','0','1','2016-12-17 12:54:16','1','2016-12-17 12:54:16','','0'),('58','1','咨询','cms_guestbook','留言板分类','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('59','2','建议','cms_guestbook','留言板分类','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5d231108b30945ab82240cb9cd198578','23','ACG动漫','music_style','ACG动漫风格','90','0','1','2016-12-17 12:50:28','1','2016-12-27 11:54:47','','0'),('5d84c2d6c6994a72aa08b19198300a81','24','布鲁斯','music_style','布鲁斯风格','100','0','1','2016-12-17 12:50:44','1','2016-12-27 11:54:52','','0'),('5e65ac3882d54d439161aaff1a863793','6','雨天','season_type','雨天','70','0','1','2016-12-29 09:52:50','1','2016-12-29 09:52:50','','0'),('5eb8199a2a124c589ed385dd67771608','10','清新','emotion_type','清新','110','0','1','2016-12-17 13:06:02','1','2016-12-17 13:06:02','','0'),('5f28c1a060744e588ca60587be7648bc','18','萨克斯','instrument_type','萨克斯','90','0','1','2016-12-17 13:10:46','1','2016-12-27 11:59:24','','0'),('6','0','否','yes_no','是/否','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('60','3','投诉','cms_guestbook','留言板分类','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('60f90b44f28e453abf7bf5d7878dc967','1','私有','owner_type','音乐类型','20','0','1','2016-12-13 11:07:01','1','2016-12-13 11:07:01','','0'),('61','4','其它','cms_guestbook','留言板分类','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('62','1','公休','oa_leave_type','请假类型','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('620eea7c47824d448206855c6c5c987a','0','主题','theme_type','主题','10','0','1','2016-12-17 13:11:46','1','2016-12-17 13:12:16','','0'),('63','2','病假','oa_leave_type','请假类型','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('64','3','事假','oa_leave_type','请假类型','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('65','4','调休','oa_leave_type','请假类型','40','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('66','5','婚假','oa_leave_type','请假类型','60','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('66727dc63ed74a45b28289524265b0dc','2','风格','theme_type','风格','30','0','1','2016-12-17 13:12:57','1','2016-12-17 13:12:57','','0'),('67','1','接入日志','sys_log_type','日志类型','30','0','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('67f3d9c4ab8c4dc3b7b77ef20359224b','2','视频类型','model_type','模版类型','30','0','1','2016-06-06 15:41:34','1','2016-06-06 15:41:34','','0'),('68','2','异常日志','sys_log_type','日志类型','40','0','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('6851b10f797e43c2bcd27eb0b6c46929','3','混合类型','model_type','模版类型','40','0','1','2016-06-06 15:41:53','1','2016-06-06 15:41:53','','0'),('689b86ab2d5c4864b4a4dcb359f3fc0e','2','未发布','programStrategyType','节目策略类型','20','0','1','2016-10-18 15:32:44','1','2016-10-21 16:43:08','','0'),('69','leave','请假流程','act_type','流程类型','10','0','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('6a23382ff7c74cbc90c5cba7592899e1','2','情人节','holiday_type','情人节','30','0','1','2016-12-17 13:14:23','1','2016-12-17 13:14:23','','0'),('6bafc033037f4e308c50af7a5d704e44','3','插播','theme_type','插播','40','0','1','2016-12-17 13:13:12','1','2016-12-17 13:13:12','','0'),('6cd0721cf3d04482b579e255b48d2c20','13','雷鬼','music_style','雷鬼风格','140','0','1','2016-12-17 12:52:47','1','2016-12-17 12:52:47','','1'),('7','red','红色','color','颜色值','10','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('70','test_audit','审批测试流程','act_type','流程类型','20','0','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('70ff717ee10c44f78285c6a983179597','3','星期三','week','星期三','30','0','1','2016-12-22 14:34:03','1','2016-12-22 14:34:03','','0'),('71','1','分类1','act_category','流程分类','10','0','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('72','2','分类2','act_category','流程分类','20','0','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('72846f643fc542de9d15f465cc87ab54','4','晴天','season_type','晴天','50','0','1','2016-12-17 13:17:33','1','2016-12-17 13:17:33','','0'),('73','crud','增删改查','gen_category','代码生成分类','10','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('733814a26a5a455eab266ec75b6dac97','7','父亲节','holiday_type','父亲节','80','0','1','2016-12-17 13:15:47','1','2016-12-17 13:15:47','','0'),('74','crud_many','增删改查（包含从表）','gen_category','代码生成分类','20','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('74014c4be5da4999a59df34547a07826','18','复古','element_type','复古','90','0','1','2016-12-17 13:01:13','1','2016-12-27 12:00:14','','0'),('75','tree','树结构','gen_category','代码生成分类','30','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('76','=','=','gen_query_type','查询方式','10','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('77','!=','!=','gen_query_type','查询方式','20','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('78','&gt;','&gt;','gen_query_type','查询方式','30','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('79','&lt;','&lt;','gen_query_type','查询方式','40','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('7a660ffd909a468db2c7b1c1a41542b6','2','秋天','season_type','秋天','30','0','1','2016-12-17 13:16:59','1','2016-12-17 13:16:59','','0'),('7b586f8f176b4228bba0e0fe138f62ed','12','弛放','music_style','弛放风格','130','0','1','2016-12-17 12:52:00','1','2016-12-17 12:52:00','','0'),('7cd7d42fae5a48ba8d36ab2d35c058e4','5','母亲节','holiday_type','母亲节','60','0','1','2016-12-17 13:15:14','1','2016-12-17 13:15:14','','0'),('8','green','绿色','color','颜色值','20','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('80','between','Between','gen_query_type','查询方式','50','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('80ca28c81d3e46b7b0c962ad5a74984a','3000','图片轮播时间','image_idle','轮播时间','10','0','1','2016-10-28 11:37:01','1','2016-10-28 11:46:44','','0'),('81','like','Like','gen_query_type','查询方式','60','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('82','left_like','Left Like','gen_query_type','查询方式','70','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('8223bfc1ce984ccba95add06600f3fcc','4','劳动节','holiday_type','劳动节','50','0','1','2016-12-17 13:14:54','1','2016-12-17 13:14:54','','0'),('83','right_like','Right Like','gen_query_type','查询方式','80','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('84','input','文本框','gen_show_type','字段生成方案','10','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('8425ddff750e4f2aacfc80af245d24d4','5','业态','sys_office_type','机构类型','100','0','1','2017-01-13 15:34:40','1','2017-01-13 15:34:40','','0'),('85','textarea','文本域','gen_show_type','字段生成方案','20','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('85bac29eda794db5b6973264320fb50e','16','大提琴','instrument_type','大提琴','70','0','1','2016-12-17 13:10:14','1','2016-12-27 11:59:17','','0'),('86','select','下拉框','gen_show_type','字段生成方案','30','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('87','checkbox','复选框','gen_show_type','字段生成方案','40','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('88','radiobox','单选框','gen_show_type','字段生成方案','50','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('89','dateselect','日期选择','gen_show_type','字段生成方案','60','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('89439b230b774450ade3bad162ba2130','2','走廊','unit_type','终端机构类型','30','0','1','2016-06-07 09:56:39','1','2016-06-07 09:56:39','','0'),('8a83c00702764630ae4aff8f94e96bc4','15','流行','music_style','音乐风格','10','0','1','2016-12-17 12:45:58','1','2016-12-27 11:53:58','','0'),('9','blue','蓝色','color','颜色值','30','0','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('90','userselect','人员选择\0','gen_show_type','字段生成方案','70','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('91','officeselect','部门选择','gen_show_type','字段生成方案','80','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('91fcf35ee4dd48f2bd21fb9c7616d431','17','活力','emotion_type','活力','30','0','1','2016-12-17 13:03:28','1','2016-12-27 11:56:25','','0'),('92','areaselect','区域选择','gen_show_type','字段生成方案','90','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('93','String','String','gen_java_type','Java类型','10','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('94','Long','Long','gen_java_type','Java类型','20','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('95','dao','仅持久层','gen_category','代码生成分类\0\0\0\0\0\0','40','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('9506b03e43944eff83d21bbd14521c11','0','新年','holiday_type','新年','10','0','1','2016-12-17 13:13:48','1','2016-12-17 13:13:48','','0'),('96','1','男','sex','性别','10','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'0'),('97','2','女','sex','性别','20','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'0'),('9708d118cb67405293c242ca6b4446a8','19','摇摆','emotion_type','摇摆','50','0','1','2016-12-17 13:03:56','1','2016-12-27 11:56:37','','0'),('98','Integer','Integer','gen_java_type','Java类型\0\0','30','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('99','Double','Double','gen_java_type','Java类型\0\0','40','0','1','2013-10-28 08:00:00','1','2013-10-28 08:00:00',NULL,'1'),('9b7f095868044de9b70931925012a868','2','已提交','program_status','节目状态','20','0','1','2016-06-06 15:44:35','1','2016-10-24 16:04:45','','0'),('9c72d8bded5642fc9e2841927e5db4d4','mix','混合模板','template_type','模板类型','40','0','1','2016-10-19 10:36:32','1','2016-10-19 10:36:32','','0'),('9e313ecfa0d445f4b354ee7bca47dedf','19','节奏布鲁斯','music_style','节奏布鲁斯风格','50','0','1','2016-12-17 12:48:38','1','2016-12-27 11:54:22','','0'),('9e33671fc6e54aed9944e7364605561f','0','慢','speed_type','慢速','10','0','1','2016-12-17 12:55:28','1','2016-12-17 12:55:28','','0'),('9f04bf783c294d86957c4db164833f48','10','钢琴','instrument_type','钢琴','10','0','1','2016-12-17 13:07:48','1','2016-12-27 11:58:43','','0'),('9f2ab7d047144233b2586a9969d14244','20','爵士','music_style','爵士风格','60','0','1','2016-12-17 12:49:20','1','2016-12-27 11:54:27','','0'),('9f2c5e2ea73743f19ec359810a84fcc2','15','灵魂','element_type','灵魂','60','0','1','2016-12-17 13:00:22','1','2016-12-27 12:00:02','','0'),('9f5da6d0e8e54edbb23c59f093123088','21','活泼','emotion_type','活泼','70','0','1','2016-12-17 13:04:59','1','2016-12-27 11:56:47','','0'),('a3fa00a12f3c401e941410403a19b0cf','11','沙发音乐','music_style','沙发音乐风格','120','0','1','2016-12-17 12:51:22','1','2016-12-17 12:51:34','','0'),('a4ae5f61f3c6438dbc6efcebacac24f6','2','中速','speed_type','中速','30','0','1','2016-12-17 12:56:05','1','2016-12-17 12:56:05','','0'),('a66d08a10b8a47aea9518f872e467fc5','23','轻松','emotion_type','轻松','90','0','1','2016-12-17 13:05:32','1','2016-12-27 11:56:57','','0'),('a6a1461dcad74e02b64c251550249293','15','动感','emotion_type','动感','10','0','1','2016-12-17 13:03:03','1','2016-12-27 11:56:14','','0'),('a7b8e6881ef1440f9568376385de2c69','2','未发布','notice_status','消息状态未发布','20','0','1','2016-10-11 21:59:11','1','2016-10-11 22:00:15','填写完成的，进行了提交的，此状态可以进行发布，不可编辑，可删除','0'),('a940edfb31144aa2b17e138decdd3ac4','1','节日','theme_type','节日','20','0','1','2016-12-17 13:12:39','1','2016-12-17 13:12:39','','0'),('acdd1c93e8374572ae06e624a67d4e16','14','悠闲','emotion_type','悠闲','150','0','1','2016-12-17 13:07:06','1','2016-12-17 13:07:06','','0'),('aece75b7f9f7491bb1ee18e41a8953c2','1','图片类型','model_type','模版类型','20','0','1','2016-06-06 15:41:12','1','2016-06-06 15:41:12','','0'),('b058a6ea805f42059cd29e8dae6075c1','5','阴天','season_type','阴天','60','0','1','2016-12-29 09:52:24','1','2016-12-29 09:52:31','','0'),('b06a450362c1409ea356aa214022bbe1','13','雷鬼','music_style','雷鬼风格','140','0','1','2016-12-17 12:52:55','1','2016-12-17 12:52:55','','0'),('b1269da266ea45a2901ce7cbdac97d3f','12','舒缓','emotion_type','舒缓','130','0','1','2016-12-17 13:06:33','1','2016-12-17 13:06:33','','0'),('b34c0221d023416195ac3382e15c618d','0','文本类型','model_type','模版类型','10','0','1','2016-06-06 15:40:46','1','2016-06-06 15:40:46','','0'),('b55eaff3732046028834be48b13c7a48','22','轻快','emotion_type','轻快','80','0','1','2016-12-17 13:05:16','1','2016-12-27 11:56:52','','0'),('b63b4fe7eaa94bcf8d1263b0e70659b4','txt','文本类型','template_type','模板类型','10','0','1','2016-10-19 10:34:56','1','2016-10-19 10:35:42','','0'),('bb5e6565b5324e999d03393766d3cbd7','0','公共','owner_type','音乐类型','10','0','1','2016-12-13 11:06:24','1','2016-12-13 11:06:24','','0'),('bc600c4af9af48b3a1a45ab034e01129','4','快速','speed_type','快速','50','0','1','2016-12-17 12:56:55','1','2016-12-17 12:56:55','','0'),('bd120322292948988fe0ba81bdab2ec7','16','甜美','element_type','甜美','70','0','1','2016-12-17 13:00:44','1','2016-12-27 12:00:06','','0'),('c0358986386744018f09c6ad70debc0a','20','欢快','emotion_type','欢快','60','0','1','2016-12-17 13:04:10','1','2016-12-27 11:56:42','','0'),('c37ebbf26b58496aa7fb755bb2175eea','22','轻音乐','music_style','轻音乐风格','80','0','1','2016-12-17 12:50:13','1','2016-12-27 11:54:42','','0'),('c38f8cb6a2eb4a7c9b9adb45c65d8af3','17','电子','music_style','电子风格','30','0','1','2016-12-17 12:47:06','1','2016-12-27 11:54:10','','0'),('c652e453214746d887d69197da418a18','3','乐器','voice_type','乐器','40','0','1','2016-12-17 12:58:28','1','2016-12-17 12:58:28','','0'),('cb67c11f48c141a5a2a343e43b2285fd','10','新世纪世界音乐','music_style','新世纪世界音乐风格','110','0','1','2016-12-17 12:51:02','1','2016-12-17 12:51:02','','0'),('cc75404606b24c8bb6ebf43d8fdc8544','19','科技感','element_type','科技感','100','0','1','2016-12-17 13:02:04','1','2016-12-27 12:00:17','','0'),('cecbc2e2f4f244b99747230a9352de40','12','磁性','element_type','磁性','30','0','1','2016-12-17 12:59:32','1','2016-12-27 11:59:48','','0'),('cf38dc9e41b24ade8d40859cfc1651dc','14','拉丁','music_style','拉丁风格','150','0','1','2016-12-17 12:53:27','1','2016-12-17 12:53:27','','0'),('d256d7ec5cd64e3aa7a32fcf86e2b8e6','21','嘻哈','music_style','嘻哈风格','70','0','1','2016-12-17 12:49:37','1','2016-12-27 11:54:32','','0'),('d3023a15b33a46a992a199393267f6c3','1','咖啡厅','site_type','咖啡厅场所','20','0','1','2016-12-17 12:54:36','1','2016-12-17 12:54:36','','0'),('d5fad8fa51904a9e8ff2d0e677a7bae4','video','视频模板','template_type','模板类型','20','0','1','2016-10-19 10:36:02','1','2016-10-19 10:36:02','','0'),('d68639df387446e29d14de9dd63e9fa4','13','贝司','instrument_type','贝司','40','0','1','2016-12-17 13:08:35','1','2016-12-27 11:58:59','','0'),('d7113c0dffd4429f9056322bc3f6a51c','7','大雾','season_type','大雾','80','0','1','2016-12-29 09:53:09','1','2016-12-29 09:53:09','','0'),('dd698d6dc203406dad7a14c7e2a3ceef','3','稍快','speed_type','稍快','40','0','1','2016-12-17 12:56:37','1','2016-12-17 12:56:37','','0'),('dd8ba6c59c5c46a4b52b73d8df1c472b','16','明快','emotion_type','明快','20','0','1','2016-12-17 13:03:17','1','2016-12-27 11:56:19','','0'),('de2a749e6dc54cc8b0de9319eccfb54e','3','冬天','season_type','冬天','40','0','1','2016-12-17 13:17:14','1','2016-12-17 13:17:14','','0'),('de35b551b84845e69ce3dcb0732350c3','2','生活方式','style_type','生活方式','30','0','1','2016-12-29 09:55:37','1','2016-12-29 09:55:37','','0'),('e22f81c8b7474a289410a44b1942fd7e','13','沧桑','element_type','沧桑','40','0','1','2016-12-17 12:59:44','1','2016-12-27 11:59:52','','0'),('e347dd2633274732b83b6069703c8c03','1','星期一','week','星期一','10','0','1','2016-12-22 14:31:32','1','2016-12-22 14:31:32','','0'),('e4aec80f712443869b7bac8bd0047aad','4','星期四','week','星期四','40','0','1','2016-12-22 14:34:15','1','2016-12-22 14:34:15','','0'),('e788e27056fe49159a26f14ec6a33c49','0','子频道','channel_type','子频道','10','0','1','2016-12-17 13:26:53','1','2016-12-17 13:26:53','','0'),('e822f54c2e3b4170aed151115e88a09e','4','历史主题','style_type','历史主题','50','0','1','2016-12-29 09:57:41','1','2016-12-29 09:57:52','','0'),('ea946e09af1747b38e75173f286977c8','3','电影主题','style_type','电影主题','40','0','1','2016-12-29 09:55:54','1','2016-12-29 09:55:54','','0'),('ecbb478bbd5a4c80af1468a471da9a25','1','电梯','unit_type','终端机构类型','20','0','1','2016-06-07 09:56:19','1','2016-06-07 09:56:19','','0'),('f1f1d31917694c92b4bc1e758a751864','1','绘画风格','style_type','绘画风格','20','0','1','2016-12-29 09:55:20','1','2016-12-29 09:55:20','','0'),('f2a807dad1414aaa9dad2968af3f7588','1','待提交','program_status','节目状态','10','0','1','2016-10-18 14:54:13','1','2016-10-24 16:03:44','','0'),('f2ad11b5ed1344b083766adbc5aa219c','11','吉他','instrument_type','吉他','20','0','1','2016-12-17 13:08:01','1','2016-12-27 11:58:47','','0'),('f779c4e803db48fea98e75b428aa954c','19','handpan','instrument_type','handpan','100','0','1','2016-12-17 13:11:10','1','2016-12-27 11:59:27','','0'),('f980e93f762a484f94ef3f4b60961143','2','合唱','voice_type','合唱','30','0','1','2016-12-17 12:58:12','1','2016-12-17 12:58:12','','0'),('fcb1cf887f6c4dafaf54e5da19300e74','1','夏天','season_type','夏天','20','0','1','2016-12-17 13:16:43','1','2016-12-17 13:16:43','','0'),('fcdc6965179241eca090bdcfcdd01740','1','待提交','notice_status','消息状态待提交','10','0','1','2016-10-11 21:58:35','1','2016-10-11 21:58:35','新增完成了，没有进行提交的，此状态不能发布，可编辑，可删除','0'),('fd0ec5595913486ebbd0f424f0549ce8','0','艺术风格','style_type','艺术风格','10','0','1','2016-12-29 09:55:03','1','2016-12-29 09:55:03','','0'),('ff962a5e36984fafa43f2673759a0550','0','男声','voice_type','男声','10','0','1','2016-12-17 12:57:21','1','2016-12-17 12:57:21','','0');

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '日志标题',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '操作方式',
  `params` text COLLATE utf8_bin COMMENT '操作提交的数据',
  `exception` text COLLATE utf8_bin COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='日志表';

/*Data for the table `sys_log` */


/*Table structure for table `sys_mdict` */

DROP TABLE IF EXISTS `sys_mdict`;

CREATE TABLE `sys_mdict` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_mdict_parent_id` (`parent_id`),
  KEY `sys_mdict_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多级字典表';

/*Data for the table `sys_mdict` */

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `href` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '链接',
  `target` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  `is_show` char(1) COLLATE utf8_bin NOT NULL COMMENT '是否在菜单中显示',
  `permission` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='菜单表';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`parent_id`,`parent_ids`,`name`,`sort`,`href`,`target`,`icon`,`is_show`,`permission`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('00a7f20428a54a5db62295ecab9f92a4','c96ca6d5d412493aa696d85406a5cad5','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,c96ca6d5d412493aa696d85406a5cad5,','修改','60','','','','0','sys:dict:edit','1','2016-06-02 15:46:44','1','2016-06-02 15:46:44','','0'),('06a90404e55b4d338d4a1a1cb5c74f27','eede912f457c4ac790abe7e950a28e57','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,','组合频道管理','150','/channel/groupChannel/front/user/list','','','1','','1','2017-01-04 15:29:10','1','2017-01-04 15:40:42','','0'),('081c7c39a3c0458e8d968f3a20fd5d6f','b7a53cde99ec42ca820b038f74a1d2c6','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,b7a53cde99ec42ca820b038f74a1d2c6,','插播管理','30','','','','1','','1','2016-12-07 16:56:29','1','2016-12-07 16:56:29','','1'),('0b2ebd4d639e4c2b83c2dd0764522f24','ba8092291b40482db8fe7fc006ea3d76','0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,','编辑','60','','','','0','test:testData:edit','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('0ca004d6b1bf4bcab9670a5060d82a55','3c92c17886944d0687e73e286cada573','0,1,79,3c92c17886944d0687e73e286cada573,','树结构','90','/test/testTree','','','1','','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('0d39f13b0bce4d2f8d5eb6ab0ab4b1dd','eede912f457c4ac790abe7e950a28e57','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,','频道管理','30','/userchannel/userChannel/list','','','1','','1','2016-12-25 16:01:52','1','2016-12-25 16:19:31','','0'),('1','0','0,','功能菜单','0',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('10','3','0,1,2,3,','字典管理','60','/sys/dict/',NULL,'th-list','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('11','10','0,1,2,3,10,','查看','30',NULL,NULL,NULL,'0','sys:dict:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('12','10','0,1,2,3,10,','修改','40',NULL,NULL,NULL,'0','sys:dict:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('13','2','0,1,2,','机构用户','970',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('14','13','0,1,2,13,','区域管理','50','/sys/area/',NULL,'th','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('14a974ea0e7a428fa2c52d990a0e2500','699afe2a7c4f4f48878afdab5f3b56d9','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,699afe2a7c4f4f48878afdab5f3b56d9,','编辑','60','','','','0','usermusic:cdbooOwnerMusic:edit','1','2016-12-21 16:27:13','1','2016-12-21 16:27:13','','0'),('15','14','0,1,2,13,14,','查看','30',NULL,NULL,NULL,'0','sys:area:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('15abd0d60e7f43aab75b95b8208602e5','675b1822b304489bb7571dd6c9aa8183','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,','频道管理','30','/channel/cdbooChannel/list','','','1','','1','2016-11-24 13:23:09','1','2016-12-17 13:18:50','','0'),('15e1fdd1be26412794ec7d13669d31b4','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','乐库管理','90','','','','1','','1','2016-12-07 16:53:58','1','2016-12-07 16:53:58','','0'),('16','14','0,1,2,13,14,','修改','40',NULL,NULL,NULL,'0','sys:area:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('17','13','0,1,2,13,','机构管理','40','/sys/office/',NULL,'th-large','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('17254e99a45f49a097abd2cf041825b8','41bce4d151dd48049a73e440d2a50505','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,41bce4d151dd48049a73e440d2a50505,','修改','60','','','','0','sys:office:edit','1','2016-06-02 15:50:38','1','2016-06-02 15:50:38','','0'),('18','17','0,1,2,13,17,','查看','30',NULL,NULL,NULL,'0','sys:office:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('1878fc9282374f0880fe498b052b57e4','d9432954518040c696572ba3d95c39da','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,d9432954518040c696572ba3d95c39da,','查询','30','','','','0','userchannel:cdbooUserChannel:view','1','2016-12-21 16:25:52','1','2016-12-21 16:25:52','','0'),('19','17','0,1,2,13,17,','修改','40',NULL,NULL,NULL,'0','sys:office:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('1a0030810ae24c2cb44277a9315de01f','d9432954518040c696572ba3d95c39da','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,d9432954518040c696572ba3d95c39da,','编辑','60','','','','0','userchannel:cdbooUserChannel:edit','1','2016-12-21 16:26:07','1','2016-12-21 16:26:07','','0'),('2','1','0,1,','系统设置','900','','','','0','','1','2013-05-27 08:00:00','1','2016-10-08 14:20:47','','0'),('20','13','0,1,2,13,','用户管理','30','/sys/user/index',NULL,'user','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('20c759ed5e1e4cd282c64582b416ca6d','eede912f457c4ac790abe7e950a28e57','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,','计划管理','120','/userplan/cdbooPlan/userPlanList','','circle-blank','1','','1','2016-12-30 10:31:42','1','2016-12-30 10:42:52','','0'),('20dbc39ef95e49e8a647cfe82f4daa95','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','区域管理','210','/sys/area/','','','1','','1','2016-10-08 11:21:25','1','2016-10-08 11:21:25','','0'),('21','20','0,1,2,13,20,','查看','30',NULL,NULL,NULL,'0','sys:user:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('22','20','0,1,2,13,20,','修改','40',NULL,NULL,NULL,'0','sys:user:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('23','2','0,1,2,','关于帮助','990',NULL,NULL,NULL,'0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('24','23','0,1,2,23','官方首页','30','http://jeesite.com','_blank',NULL,'0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('25','23','0,1,2,23','项目支持','50','http://jeesite.com/donation.html','_blank',NULL,'0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('26','23','0,1,2,23','论坛交流','80','http://bbs.jeesite.com','_blank',NULL,'0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('26dcc4bd31aa4e4bbaffee152373c34d','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','个人信息','150','','','','1','','1','2016-10-08 14:17:24','1','2016-10-08 14:17:24','','0'),('27','1','0,1,','我的面板','100','','','','0','','1','2013-05-27 08:00:00','1','2016-10-08 14:20:14','','0'),('28','27','0,1,27,','个人信息','30',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('29','28','0,1,27,28,','个人信息','30','/sys/user/info',NULL,'user','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('2b893f7dae23467981802cdc49dc9088','2fe057ef51784d73951979f70e5afecc','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,2fe057ef51784d73951979f70e5afecc,','节目删除','90','','','','1','','1','2016-06-02 15:23:06','1','2016-06-02 15:23:06','','1'),('2df2cd5ca9f9406ab3560a5386af0ea2','c96ca6d5d412493aa696d85406a5cad5','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,c96ca6d5d412493aa696d85406a5cad5,','查看','30','','','','0','sys:dict:view','1','2016-06-02 15:46:28','1','2016-06-02 15:46:28','','0'),('2fe057ef51784d73951979f70e5afecc','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','节目管理','30','','','','1','','1','2016-06-02 15:19:07','1','2016-06-02 15:19:07','','1'),('3','2','0,1,2,','系统设置','980',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('30','28','0,1,27,28,','修改密码','40','/sys/user/modifyPwd',NULL,'lock','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('31','1','0,1,','内容管理','500','','','','0','','1','2013-05-27 08:00:00','1','2016-10-08 14:20:26','','0'),('32','31','0,1,31,','栏目设置','990',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('33','32','0,1,31,32','栏目管理','30','/cms/category/',NULL,'align-justify','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3380bcff837e4961aa79e2dbdd34aebe','7ccfbb7050bf4adb87717c93ae0b4501','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,7ccfbb7050bf4adb87717c93ae0b4501,','时段管理','30','/timestep/timestep/list','','','1','','1','2016-12-07 16:55:19','1','2016-12-17 10:21:15','','0'),('34','33','0,1,31,32,33,','查看','30',NULL,NULL,NULL,'0','cms:category:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('35','33','0,1,31,32,33,','修改','40',NULL,NULL,NULL,'0','cms:category:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('36','32','0,1,31,32','站点设置','40','/cms/site/',NULL,'certificate','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('360d2d2aed524a69aedf8af24ed38f80','26dcc4bd31aa4e4bbaffee152373c34d','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,26dcc4bd31aa4e4bbaffee152373c34d,','修改密码','60','/sys/user/modifyPwd','','','1','','1','2016-10-08 14:18:34','1','2016-10-08 14:18:34','','0'),('37','36','0,1,31,32,36,','查看','30',NULL,NULL,NULL,'0','cms:site:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3732a34c00af43388240ffe4ad8489a3','41bce4d151dd48049a73e440d2a50505','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,41bce4d151dd48049a73e440d2a50505,','查看','30','','','','0','sys:office:view','1','2016-06-02 15:50:21','1','2016-06-02 15:50:21','','0'),('38','36','0,1,31,32,36,','修改','40',NULL,NULL,NULL,'0','cms:site:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('39','32','0,1,31,32','切换站点','50','/cms/site/select',NULL,'retweet','1','cms:site:select','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('3b96544dae65488e99686f3140a43fbb','57a32223879f4182971204a64693b3ce','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,d1cd11b3157648169153deb5ae9e4306,57a32223879f4182971204a64693b3ce,','查看','30','','','','0','business:timestep:view','1','2016-12-13 10:08:10','1','2016-12-19 15:20:33','','0'),('3c92c17886944d0687e73e286cada573','79','0,1,79,','生成示例','120','','','','1','','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('4','3','0,1,2,3,','菜单管理','30','/sys/menu/',NULL,'list-alt','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('40','31','0,1,31,','内容管理','500',NULL,NULL,NULL,'1','cms:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('41','40','0,1,31,40,','内容发布','30','/cms/',NULL,'briefcase','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('41bce4d151dd48049a73e440d2a50505','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','机构管理','150','/sys/office/','','','1','','1','2016-06-02 15:49:42','1','2016-06-02 15:49:59','','0'),('42','41','0,1,31,40,41,','文章模型','40','/cms/article/',NULL,'file','0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('4220fb7eec8d45b5ba34d4b8c9472cd8','2fe057ef51784d73951979f70e5afecc','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,2fe057ef51784d73951979f70e5afecc,','节目发布','120','','','','1','','1','2016-06-02 15:23:17','1','2016-06-02 15:23:17','','1'),('42f523bc3bc24c93b1d7a3fd41fd571f','0d39f13b0bce4d2f8d5eb6ab0ab4b1dd','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,0d39f13b0bce4d2f8d5eb6ab0ab4b1dd,','查询','30','','','','0','userchannel:userChannel:view','1','2016-12-25 16:19:55','1','2016-12-25 16:19:55','','0'),('43','42','0,1,31,40,41,42,','查看','30',NULL,NULL,NULL,'0','cms:article:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('44','42','0,1,31,40,41,42,','修改','40',NULL,NULL,NULL,'0','cms:article:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('45','42','0,1,31,40,41,42,','审核','50',NULL,NULL,NULL,'0','cms:article:audit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('46','41','0,1,31,40,41,','链接模型','60','/cms/link/',NULL,'random','0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('47','46','0,1,31,40,41,46,','查看','30',NULL,NULL,NULL,'0','cms:link:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('48','46','0,1,31,40,41,46,','修改','40',NULL,NULL,NULL,'0','cms:link:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('4855cf3b25c244fb8500a380db189d97','b1f6d1b86ba24365bae7fd86c5082317','0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,','查看','30','','','','0','test:testDataMain:view','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('49','46','0,1,31,40,41,46,','审核','50',NULL,NULL,NULL,'0','cms:link:audit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('497bf29eb3504019b0a6050c9aa2702d','a5e0169b98c64494b22ff41fae36828e','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,4d1d5051b56e4bcbb0daf603a6d3473d,a5e0169b98c64494b22ff41fae36828e,','插播消息查询','90','','','','1','','1','2016-06-02 15:27:40','1','2016-06-02 15:27:40','','1'),('4bb3f18225ab4de7baa54aae8af6651e','04760cc372044016bfcaa1c363495f8b','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,4d1d5051b56e4bcbb0daf603a6d3473d,04760cc372044016bfcaa1c363495f8b,','播放控制','60','','','','1','','1','2016-06-02 15:26:26','1','2016-06-02 15:26:26','','1'),('4d1d5051b56e4bcbb0daf603a6d3473d','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','终端管理','60','','','','1','','1','2016-06-02 15:19:19','1','2016-06-02 15:19:19','','1'),('4e1dd804ed2444dd98919f2eac47d112','675b1822b304489bb7571dd6c9aa8183','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,','消息策略','60','','','','1','','1','2016-06-07 10:36:27','1','2016-06-07 10:36:27','','1'),('4eda72acbd5e40f2aec352c48306a47d','fdba81d4efec45c6bdd9e3a72427a50b','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,fdba81d4efec45c6bdd9e3a72427a50b,','编辑','60','','','','0','usertimestep:userTimestep:edit','1','2017-01-04 15:36:54','1','2017-01-04 15:36:54','','0'),('4f1a0b9b0fbd48b488c576f4a480b022','58d0b78c555c4164ad858c50215e398a','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,58d0b78c555c4164ad858c50215e398a,','查看','30','','','','0','sys:menu:view','1','2016-06-02 15:40:00','1','2016-06-02 15:40:00','','0'),('4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','1','0,1,','服务菜单','5030','','','','1','','1','2016-06-02 15:17:55','1','2016-06-02 15:17:55','','0'),('5','4','0,1,2,3,4,','查看','30',NULL,NULL,NULL,'0','sys:menu:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('50','40','0,1,31,40,','评论管理','40','/cms/comment/?status=2',NULL,'comment','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('51','50','0,1,31,40,50,','查看','30',NULL,NULL,NULL,'0','cms:comment:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('51b0856b43b0458988db1db47f54aafc','741f0bb308f14489b45ad0dbebe2033e','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,741f0bb308f14489b45ad0dbebe2033e,','查询','30','','','','0','channel:groupChannel:view','1','2016-12-31 14:53:16','1','2016-12-31 14:53:16','','0'),('51f75adfe8b642518b5ff8b839664b34','9fcc920202e7441ba7c8134d02ac0eb0','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,9fcc920202e7441ba7c8134d02ac0eb0,','日志查询','30','/sys/log','','','1','sys:log:view','1','2016-06-02 15:38:45','1','2016-06-02 15:47:14','','0'),('52','50','0,1,31,40,50,','审核','40',NULL,NULL,NULL,'0','cms:comment:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('53','40','0,1,31,40,','公共留言','80','/cms/guestbook/?status=2',NULL,'glass','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('54','53','0,1,31,40,53,','查看','30',NULL,NULL,NULL,'0','cms:guestbook:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('55','53','0,1,31,40,53,','审核','40',NULL,NULL,NULL,'0','cms:guestbook:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('56','71','0,1,27,71,','文件管理','90','/../static/ckfinder/ckfinder.html',NULL,'folder-open','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('57','56','0,1,27,40,56,','查看','30',NULL,NULL,NULL,'0','cms:ckfinder:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('57a32223879f4182971204a64693b3ce','d1cd11b3157648169153deb5ae9e4306','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,d1cd11b3157648169153deb5ae9e4306,','行业频道管理','60','/business/business/index','','bell','1','','1','2016-12-13 10:07:49','1','2016-12-19 16:33:05','','0'),('58','56','0,1,27,40,56,','上传','40',NULL,NULL,NULL,'0','cms:ckfinder:upload','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('58d0b78c555c4164ad858c50215e398a','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','菜单管理','30','/sys/menu/','','','1','','1','2016-06-02 15:37:03','1','2016-06-02 15:39:20','','0'),('59','56','0,1,27,40,56,','修改','50',NULL,NULL,NULL,'0','cms:ckfinder:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('5b35811fab744073ad5839ad65e44f16','6fc7507c5f6d483fa38fceaaa24f5569','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,','时段管理','90','/usertimestep/cdbooUserTimestep/list','','','1','','1','2016-12-21 13:45:47','1','2016-12-21 16:28:01','','0'),('5c7da928e1ed46a594a0c95ef1e47639','675b1822b304489bb7571dd6c9aa8183','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,','组合频道管理','40','','','','1','','1','2016-12-09 13:06:46','1','2016-12-09 13:06:46','','1'),('6','4','0,1,2,3,4,','修改','40',NULL,NULL,NULL,'0','sys:menu:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('60','31','0,1,31,','统计分析','600',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('61','60','0,1,31,60,','信息量统计','30','/cms/stats/article',NULL,'tasks','1','cms:stats:article','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('62','1','0,1,','在线办公','200','','','','0','','1','2013-05-27 08:00:00','1','2016-10-08 14:20:06','','0'),('63','62','0,1,62,','个人办公','30',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('631a87ca081e4956aeee765f09c21094','20dbc39ef95e49e8a647cfe82f4daa95','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,20dbc39ef95e49e8a647cfe82f4daa95,','查看','30','sys:area:view','','','0','','1','2016-10-08 11:22:24','1','2016-10-08 11:25:31','','0'),('6374e6cf0c9e487ab2447953a972551b','699afe2a7c4f4f48878afdab5f3b56d9','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,699afe2a7c4f4f48878afdab5f3b56d9,','查询','30','','','','0','usermusic:cdbooOwnerMusic:view','1','2016-12-21 16:26:57','1','2016-12-21 16:26:57','','0'),('64','63','0,1,62,63,','请假办理','300','/oa/leave',NULL,'leaf','0',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('65','64','0,1,62,63,64,','查看','30',NULL,NULL,NULL,'0','oa:leave:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('66','64','0,1,62,63,64,','修改','40',NULL,NULL,NULL,'0','oa:leave:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('67','2','0,1,2,','日志查询','985',NULL,NULL,NULL,'1',NULL,'1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('675b1822b304489bb7571dd6c9aa8183','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','频道管理','70','','','','1','','1','2016-06-07 10:35:13','1','2016-12-07 16:44:03','','0'),('68','67','0,1,2,67,','日志查询','30','/sys/log',NULL,'pencil','1','sys:log:view','1','2013-06-03 08:00:00','1','2013-06-03 08:00:00',NULL,'0'),('69','62','0,1,62,','流程管理','300',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('699afe2a7c4f4f48878afdab5f3b56d9','6fc7507c5f6d483fa38fceaaa24f5569','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,','曲库管理','60','/usermusic/cdbooOwnerMusic/list','','','1','','1','2016-12-21 13:45:37','1','2016-12-21 16:26:42','','0'),('6cd6e0d1dc27442f8289ff2ca2665b2e','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','消息管理','20','','','','1','','1','2016-10-12 21:13:38','1','2016-10-12 21:13:38','','1'),('6fc7507c5f6d483fa38fceaaa24f5569','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','客户管理','210','','','','1','','1','2016-12-21 13:43:00','1','2016-12-21 13:43:00','','0'),('7','3','0,1,2,3,','角色管理','50','/sys/role/',NULL,'lock','1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('70','69','0,1,62,69,','流程管理','50','/act/process',NULL,'road','1','act:process:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('7086efa770b3497d967364cafe9c148f','dc9069f7ddf4449981bb760f9a9b0f86','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,dc9069f7ddf4449981bb760f9a9b0f86,','修改','60','','','','0','sys:user:edit','1','2016-06-02 15:41:48','1','2016-06-02 15:47:39','','0'),('71','27','0,1,27,','文件管理','90',NULL,NULL,NULL,'1',NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('7158c214e4654e21bd461ca6109a8964','e466c8693b0e4eb7a4c05906f7b01584','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,e466c8693b0e4eb7a4c05906f7b01584,','查询','30','','','','0','channel:groupChannel:user:view','1','2016-12-30 14:22:10','1','2017-01-04 10:29:51','','0'),('72','69','0,1,62,69,','模型管理','100','/act/model',NULL,'road','1','act:model:edit','1','2013-09-20 08:00:00','1','2013-09-20 08:00:00',NULL,'0'),('73','63','0,1,62,63,','我的任务','50','/act/task/todo/',NULL,'tasks','1',NULL,'1','2013-09-24 08:00:00','1','2013-09-24 08:00:00',NULL,'0'),('74','63','0,1,62,63,','审批测试','100','/oa/testAudit',NULL,NULL,'1','oa:testAudit:view,oa:testAudit:edit','1','2013-09-24 08:00:00','1','2013-09-24 08:00:00',NULL,'0'),('741f0bb308f14489b45ad0dbebe2033e','675b1822b304489bb7571dd6c9aa8183','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,','组合频道管理','60','/channel/groupChannel/list','','','1','','1','2016-12-31 14:52:56','1','2016-12-31 14:52:56','','0'),('75','1','0,1,','在线演示','3000',NULL,NULL,NULL,'1',NULL,'1','2013-10-08 08:00:00','1','2013-10-08 08:00:00',NULL,'1'),('79','1','0,1,','代码生成','5000','','','','0','','1','2013-10-16 08:00:00','1','2016-10-08 14:21:18','','0'),('7cc3849b17cb4d588aa62078b5d3120e','e466c8693b0e4eb7a4c05906f7b01584','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,e466c8693b0e4eb7a4c05906f7b01584,','编辑','60','','','','0','channel:groupChannel:user:edit','1','2016-12-30 14:22:30','1','2017-01-04 10:30:05','','0'),('7ccfbb7050bf4adb87717c93ae0b4501','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','时段管理','80','','','','1','','1','2016-12-07 16:47:40','1','2016-12-07 16:47:40','','0'),('7fdeaea7b9874b1c8dd5bd7d939ed567','6fc7507c5f6d483fa38fceaaa24f5569','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,','插播计划管理','150','','','','1','','1','2016-12-21 13:48:37','1','2016-12-21 13:48:37','','1'),('8','7','0,1,2,3,7,','查看','30',NULL,NULL,NULL,'0','sys:role:view','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('80','79','0,1,79,','代码生成','50',NULL,NULL,NULL,'1',NULL,'1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'0'),('81','80','0,1,79,80,','生成方案配置','30','/gen/genScheme',NULL,NULL,'1','gen:genScheme:view,gen:genScheme:edit','1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'0'),('815a2d6efe424325bbe843ca9efb4d0d','2fe057ef51784d73951979f70e5afecc','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,2fe057ef51784d73951979f70e5afecc,','节目策略','90','','','','1','','1','2016-06-07 10:33:28','1','2016-06-07 10:33:28','','1'),('82','80','0,1,79,80,','业务表配置','20','/gen/genTable',NULL,NULL,'1','gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit','1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'0'),('83','80','0,1,79,80,','代码模板管理','90','/gen/genTemplate',NULL,NULL,'1','gen:genTemplate:view,gen:genTemplate:edit','1','2013-10-16 08:00:00','1','2013-10-16 08:00:00',NULL,'1'),('84','67','0,1,2,67,','连接池监视','40','/../druid',NULL,NULL,'1',NULL,'1','2013-10-18 08:00:00','1','2013-10-18 08:00:00',NULL,'0'),('84ecf60c48b64a3bbbcf6a2817a5f110','6fc7507c5f6d483fa38fceaaa24f5569','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,','计划管理','120','/userplan/cdbooPlan/list','','','1','','1','2016-12-21 13:48:13','1','2016-12-21 16:29:15','','0'),('85','76','0,1,75,76,','行政区域','80','/../static/map/map-city.html',NULL,NULL,'1',NULL,'1','2013-10-22 08:00:00','1','2013-10-22 08:00:00',NULL,'0'),('86','75','0,1,75,','组件演示','50',NULL,NULL,NULL,'1',NULL,'1','2013-10-22 08:00:00','1','2013-10-22 08:00:00',NULL,'1'),('87','86','0,1,75,86,','组件演示','30','/test/test/form',NULL,NULL,'1','test:test:view,test:test:edit','1','2013-10-22 08:00:00','1','2013-10-22 08:00:00',NULL,'1'),('88','62','0,1,62,','通知通告','20','','','','1','','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('89','88','0,1,62,88,','我的通告','30','/oa/oaNotify/self','','','1','','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('893b170cf8d244b28a7a8ef87129e33b','ccbdc6b0feab417097ae035f19930431','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,9a886387af9c44d5b8fabe40023352a3,ccbdc6b0feab417097ae035f19930431,','查看','30','','','','0','plan.plan.view','1','2016-12-20 16:28:35','1','2016-12-20 16:28:35','','1'),('8c246b31104f4181878112e74edf28bd','efb08e4cca49454da7c60c9a66d367f8','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,15e1fdd1be26412794ec7d13669d31b4,efb08e4cca49454da7c60c9a66d367f8,','查询','30','','','','0','music:cdbooMusic:view','1','2016-12-13 10:53:38','1','2016-12-13 10:53:59','','0'),('8e30fa7f3ace4180826da9fa6ac4b694','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','代码生成','180','','','','0','','1','2016-06-02 15:50:58','1','2017-01-16 08:31:15','','0'),('9','7','0,1,2,3,7,','修改','40',NULL,NULL,NULL,'0','sys:role:edit','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'0'),('90','88','0,1,62,88,','通告管理','50','/oa/oaNotify','','','1','oa:oaNotify:view,oa:oaNotify:edit','1','2013-11-08 08:00:00','1','2013-11-08 08:00:00',NULL,'0'),('919526a9417044788af085d864801794','06a90404e55b4d338d4a1a1cb5c74f27','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,06a90404e55b4d338d4a1a1cb5c74f27,','查询','30','','','','0','channel:groupChannel:user:front:view','1','2017-01-04 15:29:27','1','2017-01-04 15:29:27','','0'),('9991b55f815c43d0b2ff511c73b61d96','ccbdc6b0feab417097ae035f19930431','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,9a886387af9c44d5b8fabe40023352a3,ccbdc6b0feab417097ae035f19930431,','编辑','60','','','','0','plan.plan.edit','1','2016-12-20 16:28:59','1','2016-12-20 16:28:59','','1'),('9a886387af9c44d5b8fabe40023352a3','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','计划管理','180','','','certificate','1','','1','2016-12-20 16:06:55','1','2016-12-20 16:27:45','','1'),('9b475e05d3ba4e1786dac61d7f81bb4c','84ecf60c48b64a3bbbcf6a2817a5f110','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,84ecf60c48b64a3bbbcf6a2817a5f110,','编辑','60','','','','0','userplan:cdbooPlan:edit','1','2016-12-21 16:35:59','1','2016-12-21 16:35:59','','0'),('9c2989e7c81d4c31a71074c608f99cd1','26dcc4bd31aa4e4bbaffee152373c34d','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,26dcc4bd31aa4e4bbaffee152373c34d,','个人信息','30','/sys/user/info','','','1','','1','2016-10-08 14:18:12','1','2016-10-08 14:18:12','','0'),('9d458d0bc2c843ddaf16d63da0dbc689','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','角色管理','90','/sys/role/','','','1','','1','2016-06-02 15:37:29','1','2016-06-02 15:43:17','','0'),('9fcc920202e7441ba7c8134d02ac0eb0','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','日志管理','120','','','','1','','1','2016-06-02 15:20:00','1','2016-06-02 15:20:00','','0'),('a032b46de763467d9e5087866a4f5626','04760cc372044016bfcaa1c363495f8b','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,4d1d5051b56e4bcbb0daf603a6d3473d,04760cc372044016bfcaa1c363495f8b,','节目推送','30','','','','1','','1','2016-06-02 15:26:10','1','2016-06-02 15:26:10','','1'),('a036848f946c4fb6bc25ccac81869e7a','5b35811fab744073ad5839ad65e44f16','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,5b35811fab744073ad5839ad65e44f16,','查询','30','','','','0','usertimestep:cdbooUserTimestep:view','1','2016-12-21 16:28:21','1','2016-12-21 16:28:21','','0'),('a46cce6cb1c74f4eb247cfdcf6691a15','e381f83ea3b84693bf93ba1ba6a75b16','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,e381f83ea3b84693bf93ba1ba6a75b16,','查询','30','','','','0','usermusic:ownerMusic:view','1','2017-01-04 15:35:44','1','2017-01-04 15:35:44','','0'),('a5e0169b98c64494b22ff41fae36828e','4d1d5051b56e4bcbb0daf603a6d3473d','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,4d1d5051b56e4bcbb0daf603a6d3473d,','消息插播管理','90','','','','1','','1','2016-06-02 15:24:18','1','2016-06-02 15:24:18','','1'),('a66e1580ad7d4881bec23c9bd3810b1f','57a32223879f4182971204a64693b3ce','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,d1cd11b3157648169153deb5ae9e4306,57a32223879f4182971204a64693b3ce,','编辑','60','','','','0','business:timestep:edit','1','2016-12-13 10:08:51','1','2016-12-19 15:20:50','','0'),('a7b33e2abc9a49d69d206f29d73d1d6f','20dbc39ef95e49e8a647cfe82f4daa95','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,20dbc39ef95e49e8a647cfe82f4daa95,','修改','60','sys:area:edit','','','0','','1','2016-10-08 11:22:52','1','2016-10-08 11:25:57','','0'),('a992c9fe83f145fbbaa704ce14a4ef01','dc9069f7ddf4449981bb760f9a9b0f86','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,dc9069f7ddf4449981bb760f9a9b0f86,','查看','30','','','','0','sys:user:view','1','2016-06-02 15:41:28','1','2016-06-02 15:41:28','','0'),('ad04d92e43444300b34db4d7b39ad60b','5b35811fab744073ad5839ad65e44f16','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,5b35811fab744073ad5839ad65e44f16,','编辑','60','','','','0','usertimestep:cdbooUserTimestep:edit','1','2016-12-21 16:28:41','1','2016-12-21 16:28:41','','0'),('afab2db430e2457f9cf3a11feaa8b869','0ca004d6b1bf4bcab9670a5060d82a55','0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,','编辑','60','','','','0','test:testTree:edit','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('b0e3fbc3e69f4264b96ecae790dcb748','a5e0169b98c64494b22ff41fae36828e','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,4d1d5051b56e4bcbb0daf603a6d3473d,a5e0169b98c64494b22ff41fae36828e,','插播消息控制','60','','','','1','','1','2016-06-02 15:27:19','1','2016-06-02 15:27:19','','1'),('b100dff53e9a44a6add4b0119ee8f1b3','15abd0d60e7f43aab75b95b8208602e5','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,15abd0d60e7f43aab75b95b8208602e5,','查询','30','','','','0','channel:cdbooChannel:view','1','2016-12-17 13:19:43','1','2016-12-17 13:19:43','','0'),('b1f6d1b86ba24365bae7fd86c5082317','3c92c17886944d0687e73e286cada573','0,1,79,3c92c17886944d0687e73e286cada573,','主子表','60','/test/testDataMain','','','1','','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('b7a53cde99ec42ca820b038f74a1d2c6','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','插播管理','100','','','','1','','1','2016-12-07 16:55:56','1','2016-12-07 16:55:56','','1'),('ba8092291b40482db8fe7fc006ea3d76','3c92c17886944d0687e73e286cada573','0,1,79,3c92c17886944d0687e73e286cada573,','单表','30','/test/testData','','','1','','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('ba99e66660934a6098c33422ddb85fa0','0d39f13b0bce4d2f8d5eb6ab0ab4b1dd','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,0d39f13b0bce4d2f8d5eb6ab0ab4b1dd,','编辑','60','','','','0','userchannel:userChannel:edit','1','2016-12-25 16:20:20','1','2016-12-25 16:20:20','','0'),('c1621d7d063a42059c402732fb719be7','20c759ed5e1e4cd282c64582b416ca6d','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,20c759ed5e1e4cd282c64582b416ca6d,','查看','30','','','','0','userplan:cdbooPlan:view','1','2016-12-30 10:33:15','1','2016-12-30 10:41:16','','0'),('c268bd5b80084a56bc03a43618a45608','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','首页','240','/taluser/talUser','','','0','taluser:talUser:view','1','2016-12-28 11:57:43','1','2017-01-16 08:30:57','','0'),('c2c7c82d09354db8b79ca45d60be8c61','741f0bb308f14489b45ad0dbebe2033e','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,741f0bb308f14489b45ad0dbebe2033e,','编辑','60','','','','0','channel:groupChannel:edit','1','2016-12-31 14:53:34','1','2016-12-31 14:53:34','','0'),('c433fe2b1cee4dc7a09a3c53b9778c0f','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','系统管理','140','','','','1','','1','2016-06-02 15:19:51','1','2016-06-02 15:19:51','','0'),('c45ed914b6924ed48b1666f243760cae','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','终端机构','20','','','','0','','1','2016-06-07 09:45:22','1','2016-10-08 14:22:11','','0'),('c54ba9edc75844c3a62e7d03b4ef240c','9d458d0bc2c843ddaf16d63da0dbc689','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,9d458d0bc2c843ddaf16d63da0dbc689,','查看','30','','','','0','sys:role:view','1','2016-06-02 15:43:35','1','2016-06-02 15:47:24','','0'),('c6f0cb7e507c4557b341b5d85decc854','d1cd11b3157648169153deb5ae9e4306','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,d1cd11b3157648169153deb5ae9e4306,','行业管理','30','/business/business/','','fire','1','','1','2016-12-02 10:39:07','1','2016-12-02 10:41:16','','0'),('c884f9b01526434981705388076365be','3380bcff837e4961aa79e2dbdd34aebe','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,7ccfbb7050bf4adb87717c93ae0b4501,3380bcff837e4961aa79e2dbdd34aebe,','编辑','60','','','','0','timestep:timestep:edit','1','2016-12-17 10:20:43','1','2016-12-17 10:20:43','','0'),('c96ca6d5d412493aa696d85406a5cad5','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','字典管理','120','/sys/dict/','','','1','','1','2016-06-02 15:37:38','1','2016-06-02 15:46:06','','0'),('cbc946571fa248eda75c15a38aa1b2eb','c6f0cb7e507c4557b341b5d85decc854','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,d1cd11b3157648169153deb5ae9e4306,c6f0cb7e507c4557b341b5d85decc854,','查看','30','','','','0','business:business:view','1','2016-12-02 10:39:33','1','2016-12-02 10:39:33','','0'),('cc1b8e6afbcc49478e0f41030c05e552','20c759ed5e1e4cd282c64582b416ca6d','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,20c759ed5e1e4cd282c64582b416ca6d,','编辑','60','','','','0','userplan:cdbooPlan:edit','1','2016-12-30 10:33:33','1','2016-12-30 10:41:29','','0'),('ccbdc6b0feab417097ae035f19930431','9a886387af9c44d5b8fabe40023352a3','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,9a886387af9c44d5b8fabe40023352a3,','计划管理','30','1111','','','1','','1','2016-12-20 16:27:29','1','2016-12-20 16:27:29','','1'),('cd924730f8fb49519d0de987f3d3c184','8e30fa7f3ace4180826da9fa6ac4b694','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,8e30fa7f3ace4180826da9fa6ac4b694,','业务表配置','30','/gen/genTable','','','1','gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit','1','2016-06-02 15:51:22','1','2016-06-02 15:52:03','','0'),('ce7f821ebf204747b70cd5872c60924f','3380bcff837e4961aa79e2dbdd34aebe','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,7ccfbb7050bf4adb87717c93ae0b4501,3380bcff837e4961aa79e2dbdd34aebe,','查询','30','','','','0','timestep:timestep:view','1','2016-12-17 10:20:20','1','2016-12-17 10:20:20','','0'),('d15ec45a4c5449c3bbd7a61d5f9dd1d2','b1f6d1b86ba24365bae7fd86c5082317','0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,','编辑','60','','','','0','test:testDataMain:edit','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('d1cd11b3157648169153deb5ae9e4306','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','行业管理','110','','','asterisk','1','','1','2016-12-02 10:37:50','1','2016-12-07 16:46:01','','0'),('d366e67d0b2c48f9a4591e857b26dd41','9d458d0bc2c843ddaf16d63da0dbc689','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,9d458d0bc2c843ddaf16d63da0dbc689,','修改','60','','','','0','sys:role:edit','1','2016-06-02 15:43:53','1','2016-06-02 15:47:31','','0'),('d8bececa356d49b0b7e20f932fa0c625','2fe057ef51784d73951979f70e5afecc','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,2fe057ef51784d73951979f70e5afecc,','节目编辑','150','','','','1','','1','2016-06-02 15:23:30','1','2016-06-02 15:23:30','','1'),('d9432954518040c696572ba3d95c39da','6fc7507c5f6d483fa38fceaaa24f5569','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,','频道管理','30','/userchannel/cdbooUserChannel/list','','','1','','1','2016-12-21 13:45:07','1','2016-12-21 16:25:32','','0'),('dc9069f7ddf4449981bb760f9a9b0f86','c433fe2b1cee4dc7a09a3c53b9778c0f','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,','用户管理','60','/sys/user/index','','','1','','1','2016-06-02 15:37:18','1','2016-06-02 15:40:59','','0'),('df7ce823c5b24ff9bada43d992f373e2','ba8092291b40482db8fe7fc006ea3d76','0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,','查看','30','','','','0','test:testData:view','1','2013-08-12 13:10:05','1','2013-08-12 13:10:05','','0'),('dffa585a19c44b619bc9ba52e83cd532','8e30fa7f3ace4180826da9fa6ac4b694','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,8e30fa7f3ace4180826da9fa6ac4b694,','生成方案配置','60','/gen/genScheme','','','1','gen:genScheme:view,gen:genScheme:edit','1','2016-06-02 15:52:19','1','2016-06-02 15:52:58','','0'),('e031ccc2441045d79f3a1828c46b2989','58d0b78c555c4164ad858c50215e398a','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,c433fe2b1cee4dc7a09a3c53b9778c0f,58d0b78c555c4164ad858c50215e398a,','修改','60','','','','0','sys:menu:edit','1','2016-06-02 15:40:35','1','2016-06-02 15:47:53','','0'),('e381f83ea3b84693bf93ba1ba6a75b16','eede912f457c4ac790abe7e950a28e57','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,','曲库管理','60','/usermusic/ownerMusic/list','','','1','','1','2016-12-25 16:02:03','1','2017-01-04 15:35:29','','0'),('e466c8693b0e4eb7a4c05906f7b01584','6fc7507c5f6d483fa38fceaaa24f5569','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,','组合频道管理','31','/channel/groupChannel/user/list','','','1','','1','2016-12-30 14:21:45','1','2017-01-04 10:28:16','','0'),('ea014099e52646cfaf89889115cacc71','15abd0d60e7f43aab75b95b8208602e5','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,15abd0d60e7f43aab75b95b8208602e5,','编辑','60','','','','0','channel:cdbooChannel:edit','1','2016-12-17 13:20:11','1','2016-12-17 13:20:11','','0'),('ec433dd2849e4d08920e2f3f8eed17a8','c6f0cb7e507c4557b341b5d85decc854','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,d1cd11b3157648169153deb5ae9e4306,c6f0cb7e507c4557b341b5d85decc854,','修改','60','','','','0','business:business:edit','1','2016-12-02 10:39:56','1','2016-12-02 10:39:56','','0'),('ec6c17a64a2d41279b6ee3ff5c888c24','15abd0d60e7f43aab75b95b8208602e5','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,15abd0d60e7f43aab75b95b8208602e5,','主题频道','30','','','','1','','1','2016-12-09 13:08:43','1','2016-12-09 13:08:43','','1'),('eede912f457c4ac790abe7e950a28e57','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,','用户管理','240','','','','1','','1','2016-12-25 16:01:32','1','2016-12-25 16:01:32','','0'),('efb08e4cca49454da7c60c9a66d367f8','15e1fdd1be26412794ec7d13669d31b4','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,15e1fdd1be26412794ec7d13669d31b4,','音乐管理','30','/music/cdbooMusic/list','','','1','','1','2016-12-07 16:54:46','1','2016-12-13 10:52:55','','0'),('f764d2f8d4c840af92832d770adf14f3','15abd0d60e7f43aab75b95b8208602e5','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,675b1822b304489bb7571dd6c9aa8183,15abd0d60e7f43aab75b95b8208602e5,','节日频道','60','','','','1','','1','2016-12-09 13:09:13','1','2016-12-09 13:09:13','','1'),('fa7e5d84de10402891dae5c0afcb0a08','a5e0169b98c64494b22ff41fae36828e','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,4d1d5051b56e4bcbb0daf603a6d3473d,a5e0169b98c64494b22ff41fae36828e,','插播消息增加','30','','','','1','','1','2016-06-02 15:27:02','1','2016-06-02 15:27:02','','1'),('fba8bce2118f4f3f84cf16b1f485d1f7','fdba81d4efec45c6bdd9e3a72427a50b','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,fdba81d4efec45c6bdd9e3a72427a50b,','查询','30','','','','0','usertimestep:userTimestep:view','1','2017-01-04 15:36:41','1','2017-01-04 15:36:41','','0'),('fbd01ddf5a1a419c82e506ab91c5066f','84ecf60c48b64a3bbbcf6a2817a5f110','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,6fc7507c5f6d483fa38fceaaa24f5569,84ecf60c48b64a3bbbcf6a2817a5f110,','查看','30','','','','0','userplan:cdbooPlan:view','1','2016-12-21 16:35:39','1','2016-12-30 10:33:00','','0'),('fdba81d4efec45c6bdd9e3a72427a50b','eede912f457c4ac790abe7e950a28e57','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,eede912f457c4ac790abe7e950a28e57,','时段管理','90','/usertimestep/userTimestep/list','','','1','','1','2016-12-25 16:02:13','1','2017-01-04 15:36:24','','0'),('fe906a6bb60e4650bb94ad9a807a734b','efb08e4cca49454da7c60c9a66d367f8','0,1,4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1,15e1fdd1be26412794ec7d13669d31b4,efb08e4cca49454da7c60c9a66d367f8,','编辑','60','','','','0','music:cdbooMusic:edit','1','2016-12-13 10:54:45','1','2016-12-13 10:54:45','','0');

/*Table structure for table `sys_office` */

DROP TABLE IF EXISTS `sys_office`;

CREATE TABLE `sys_office` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `area_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属区域',
  `code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `type` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构类型',
  `grade` char(1) COLLATE utf8_bin NOT NULL COMMENT '机构等级',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '传真',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `USEABLE` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否启用',
  `PRIMARY_PERSON` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '主负责人',
  `DEPUTY_PERSON` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '副负责人',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  `photo` varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '机构图片',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `sys_office_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='机构表';

/*Data for the table `sys_office` */

insert  into `sys_office`(`id`,`parent_id`,`parent_ids`,`name`,`sort`,`area_id`,`code`,`type`,`grade`,`address`,`zip_code`,`master`,`phone`,`fax`,`email`,`USEABLE`,`PRIMARY_PERSON`,`DEPUTY_PERSON`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`,`photo`) values ('0954b5e7d8484a1c83716e580b6c3e0b','1','0,1,','海信广场','30','1','1002','1','1','','','','','','','1','','','1','2016-12-22 10:32:35','1','2016-12-22 10:33:52','','0',NULL),('0acd4c2f5fe142258edd4ab5ffe6ad5b','fb2703e6dd1c493591a19f8dd7170027','0,1,fb2703e6dd1c493591a19f8dd7170027,','吉林省展览馆管理员','30','2','100000003001','2','3','','','','','','','1','','','1','2016-10-08 11:49:39','1','2016-10-08 13:38:20','','1',NULL),('1','0','0,','中国','10','1','100000','1','1','','','','','','','1','','','1','2013-05-27 08:00:00','1','2016-10-08 11:41:40','','0',NULL),('10','7','0,1,7,','市场部','30','3','200003','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('11','7','0,1,7,','技术部','40','3','200004','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('11312930c669486081381cc4da7018e7','1','0,1,','肯德基','30','1','100101','1','1','','','','','','','1','','','1','2016-12-22 10:31:18','1','2016-12-22 10:33:32','','0',NULL),('12','7','0,1,7,','沈阳市展览馆','0','4429c7983e3c4728b1d853dc97c2420d','201000','1','3','','','','','','','1','','','1','2013-05-27 08:00:00','1','2016-10-08 11:47:31','','1',NULL),('13','12','0,1,7,12,','公司领导','10','4','201001','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('14','12','0,1,7,12,','综合部','20','4','201002','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('15','12','0,1,7,12,','市场部','30','4','201003','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('16','12','0,1,7,12,','技术部','40','4','201004','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('17','7','0,1,7,','历下区分公司','40','5','201010','1','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('18','17','0,1,7,17,','公司领导','10','5','201011','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('19','17','0,1,7,17,','综合部','20','5','201012','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('2','1','0,1,','系统管理','10','1','100001','2','1','','','','','','','1','','','1','2013-05-27 08:00:00','1','2016-10-08 11:43:13','','0',NULL),('20','17','0,1,7,17,','市场部','30','5','201013','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('206b97292c824421b0e32a36fb9ba374','11312930c669486081381cc4da7018e7','0,1,11312930c669486081381cc4da7018e7,','后勤部','30','1','100101001','2','1','','','','','','','1','','','1','2016-12-22 10:32:02','1','2016-12-22 10:32:02','','0',NULL),('21','17','0,1,7,17,','技术部','40','5','201014','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('22','7','0,1,7,','高新区分公司','50','6','201010','1','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('23','22','0,1,7,22,','公司领导','10','6','201011','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('24','22','0,1,7,22,','综合部','20','6','201012','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('25','22','0,1,7,22,','市场部','30','6','201013','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('26','22','0,1,7,22,','技术部','40','6','201014','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('287c1470feb14b60890f9cd571ff33b8','12','0,1,7,12,','展厅二','30','4429c7983e3c4728b1d853dc97c2420d','201000003','1','3','','','','','','','1','','','1','2016-10-08 14:04:42','1','2016-10-08 14:04:42','','1',NULL),('3','1','0,1,','综合部','20','2','100002','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('35620a9b092d4a0cbd82e46a82799e86','2','0,1,2,','业态2','30','1','100001002','5','1','','','','','','','1','','','1','2017-01-13 16:37:31','1','2017-01-15 21:51:45','','0','/cdboo/userfiles/1/images/office/photo/2017/01/touxiang.jpg'),('3c6b340568c74bf688e1020f4c161331','2','0,1,2,','业态1','30','1','100001001','5','1','','','','','','','1','','','1','2017-01-13 16:37:20','1','2017-01-15 21:51:35','','0','/cdboo/userfiles/1/images/office/photo/2017/01/touxiang.jpg'),('4','1','0,1,','市场部','30','2','100003','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('412371e480224ebab130c5cd1377bb59','86b3334b98c742909e09c86f40404070','0,1,fb2703e6dd1c493591a19f8dd7170027,86b3334b98c742909e09c86f40404070,','展厅一','30','3','100000003002002','1','3','','','','','','','1','','','1','2016-10-08 13:39:07','1','2016-10-08 13:39:07','','1',NULL),('4e9ef144a37b410097df2100ec0187d5','86b3334b98c742909e09c86f40404070','0,1,fb2703e6dd1c493591a19f8dd7170027,86b3334b98c742909e09c86f40404070,','展厅三','30','3','100000003002004','1','3','','','','','','','1','','','1','2016-10-08 13:45:24','1','2016-10-08 13:45:24','','1',NULL),('5','1','0,1,','技术部','40','2','100004','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('6','1','0,1,','研发部','50','2','100005','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('6880edbcb0df44829cbb77b92d1de23c','12','0,1,7,12,','展厅三','30','4429c7983e3c4728b1d853dc97c2420d','201000004','1','3','','','','','','','1','','','1','2016-10-08 14:05:10','1','2016-10-08 14:05:10','','1',NULL),('7','1','0,1,','辽宁省展览馆','20','ee866e39f5a343ee8ba33b3a0594e211','200000','1','2','','','','','','','1','','','1','2013-05-27 08:00:00','1','2016-10-08 11:44:37','','1',NULL),('7a011661fb5c47d6b48ac9553add589b','86b3334b98c742909e09c86f40404070','0,1,fb2703e6dd1c493591a19f8dd7170027,86b3334b98c742909e09c86f40404070,','展厅二','30','3','100000003002003','1','3','','','','','','','1','','','1','2016-10-08 13:39:47','1','2016-10-08 13:39:47','','1',NULL),('7c4686fb12a34693927dae9422d317d5','11312930c669486081381cc4da7018e7','0,1,11312930c669486081381cc4da7018e7,','test','30','1','999999','2','1','','','','','','','1','','','1','2017-01-13 15:29:12','1','2017-01-13 15:31:31','','0','/cdboo/userfiles/1/images/office/photo/2017/01/%E6%89%93%E5%8D%B0%E5%BF%AB%E9%80%92%E5%8D%95%E5%8F%B7.jpg'),('8','7','0,1,7,','辽宁省展览馆管理员','10','ee866e39f5a343ee8ba33b3a0594e211','200001','2','2','','','','','','','1','','','1','2013-05-27 08:00:00','1','2016-10-08 13:38:30','','1',NULL),('86b3334b98c742909e09c86f40404070','fb2703e6dd1c493591a19f8dd7170027','0,1,fb2703e6dd1c493591a19f8dd7170027,','长春市展览馆','30','3','100000003002','1','3','','','','','','','1','','','1','2016-10-08 11:50:53','1','2016-10-08 11:51:16','','1',NULL),('9','7','0,1,7,','综合部','20','3','200002','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1',NULL),('b0106380dbc34bb5920b29a85d818749','0954b5e7d8484a1c83716e580b6c3e0b','0,1,0954b5e7d8484a1c83716e580b6c3e0b,','后勤部','30','1','1002001','2','1','','','','','','','1','','','1','2016-12-22 10:32:59','1','2016-12-22 10:32:59','','0',NULL),('c7da93b87243499b8691279b64aee7c9','12','0,1,7,12,','沈阳市展览馆管理员','30','4429c7983e3c4728b1d853dc97c2420d','201000001','2','3','','','','','','','1','','','1','2016-10-08 14:03:39','1','2016-10-08 14:03:39','','1',NULL),('ca5664b3b80f48759a30217dd440c2cd','12','0,1,7,12,','展厅一','30','4429c7983e3c4728b1d853dc97c2420d','201000002','1','3','','','','','','','1','','','1','2016-10-08 14:04:13','1','2016-10-08 14:04:13','','1',NULL),('e14a7b00f5b74aaea989e5f5e724dfed','86b3334b98c742909e09c86f40404070','0,1,fb2703e6dd1c493591a19f8dd7170027,86b3334b98c742909e09c86f40404070,','长春市展览馆管理员','30','3','100000003002001','2','3','','','','','','','1','','','1','2016-10-08 13:38:06','1','2016-10-08 13:38:06','','1',NULL),('fb2703e6dd1c493591a19f8dd7170027','1','0,1,','吉林省展览馆','30','2','100000003','1','2','','','','','','','1','','','1','2016-10-08 11:49:00','1','2016-10-08 11:50:06','','1',NULL);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `enname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '英文名称',
  `role_type` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '角色类型',
  `data_scope` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '数据范围',
  `is_sys` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否系统数据',
  `useable` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可用',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`),
  KEY `sys_role_enname` (`enname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色表';

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`office_id`,`name`,`enname`,`role_type`,`data_scope`,`is_sys`,`useable`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('1','2','系统管理员','dept','assignment','1','1','1','1','2013-05-27 08:00:00','1','2016-12-12 10:53:12','','0'),('173aeedbceef46babde811cec269b4c4','e14a7b00f5b74aaea989e5f5e724dfed','长春市展览馆管理员','ccsgly','assignment','2','1','1','1','2016-10-08 14:01:08','1','2016-10-08 14:01:08','','1'),('2','0acd4c2f5fe142258edd4ab5ffe6ad5b','吉林省展览馆管理员','gly','assignment','2','1','1','1','2013-05-27 08:00:00','1','2016-10-08 13:54:22','','1'),('270d3cc4b4f541ff9f3d11bab64bf410','8','辽宁省展览馆管理员','lnsgly','assignment','2','1','1','1','2016-10-08 14:07:16','1','2016-10-08 14:07:16','','1'),('3','1','本公司管理员','a','assignment','3',NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('33939fa3a4f7412994f266c3bd5333a1','2','普通客户','nomal','user','8','1','1','1','2016-12-22 10:35:09','1','2017-01-04 15:37:07','','0'),('4','1','部门管理员','b','assignment','4',NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('47cd9f09fd0c467392921ee1340d749d','c7da93b87243499b8691279b64aee7c9','沈阳市展览馆管理员','sysgly','assignment','2','1','1','1','2016-10-08 14:07:59','1','2016-10-08 14:07:59','','1'),('5','1','本部门管理员','c','assignment','5',NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('6','2','普通用户','d','assignment','1','1','1','1','2013-05-27 08:00:00','1','2016-06-02 10:49:25','','1'),('7','7','济南市管理员','e','assignment','9',NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1');

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色-菜单';

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`role_id`,`menu_id`) values ('1','00a7f20428a54a5db62295ecab9f92a4'),('1','0f23c43a463a4db8b6635618d619e03d'),('1','1'),('1','10'),('1','11'),('1','12'),('1','13'),('1','14'),('1','15'),('1','16'),('1','17'),('1','17254e99a45f49a097abd2cf041825b8'),('1','18'),('1','19'),('1','2'),('1','20'),('1','21'),('1','22'),('1','23'),('1','24'),('1','27'),('1','28'),('1','29'),('1','2df2cd5ca9f9406ab3560a5386af0ea2'),('1','3'),('1','30'),('1','31'),('1','32'),('1','33'),('1','34'),('1','35'),('1','36'),('1','37'),('1','3732a34c00af43388240ffe4ad8489a3'),('1','38'),('1','39'),('1','4'),('1','40'),('1','41'),('1','41bce4d151dd48049a73e440d2a50505'),('1','42'),('1','43'),('1','44'),('1','45'),('1','46'),('1','47'),('1','48'),('1','49'),('1','4f1a0b9b0fbd48b488c576f4a480b022'),('1','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1'),('1','5'),('1','50'),('1','51'),('1','51f75adfe8b642518b5ff8b839664b34'),('1','52'),('1','53'),('1','54'),('1','55'),('1','56'),('1','57'),('1','58'),('1','58d0b78c555c4164ad858c50215e398a'),('1','59'),('1','6'),('1','60'),('1','61'),('1','62'),('1','63'),('1','64'),('1','65'),('1','66'),('1','67'),('1','675b1822b304489bb7571dd6c9aa8183'),('1','68'),('1','69'),('1','7'),('1','70'),('1','7086efa770b3497d967364cafe9c148f'),('1','71'),('1','72'),('1','73'),('1','74'),('1','79'),('1','8'),('1','80'),('1','81'),('1','82'),('1','84'),('1','85'),('1','88'),('1','89'),('1','8e30fa7f3ace4180826da9fa6ac4b694'),('1','9'),('1','90'),('1','9d458d0bc2c843ddaf16d63da0dbc689'),('1','9fcc920202e7441ba7c8134d02ac0eb0'),('1','a992c9fe83f145fbbaa704ce14a4ef01'),('1','c433fe2b1cee4dc7a09a3c53b9778c0f'),('1','c45ed914b6924ed48b1666f243760cae'),('1','c54ba9edc75844c3a62e7d03b4ef240c'),('1','c6f0cb7e507c4557b341b5d85decc854'),('1','c96ca6d5d412493aa696d85406a5cad5'),('1','cbc946571fa248eda75c15a38aa1b2eb'),('1','cd924730f8fb49519d0de987f3d3c184'),('1','d1cd11b3157648169153deb5ae9e4306'),('1','d366e67d0b2c48f9a4591e857b26dd41'),('1','dc9069f7ddf4449981bb760f9a9b0f86'),('1','dffa585a19c44b619bc9ba52e83cd532'),('1','e031ccc2441045d79f3a1828c46b2989'),('1','ec433dd2849e4d08920e2f3f8eed17a8'),('173aeedbceef46babde811cec269b4c4','00a7f20428a54a5db62295ecab9f92a4'),('173aeedbceef46babde811cec269b4c4','04760cc372044016bfcaa1c363495f8b'),('173aeedbceef46babde811cec269b4c4','0b2ebd4d639e4c2b83c2dd0764522f24'),('173aeedbceef46babde811cec269b4c4','0ca004d6b1bf4bcab9670a5060d82a55'),('173aeedbceef46babde811cec269b4c4','1'),('173aeedbceef46babde811cec269b4c4','10'),('173aeedbceef46babde811cec269b4c4','11'),('173aeedbceef46babde811cec269b4c4','12'),('173aeedbceef46babde811cec269b4c4','13'),('173aeedbceef46babde811cec269b4c4','14'),('173aeedbceef46babde811cec269b4c4','15'),('173aeedbceef46babde811cec269b4c4','16'),('173aeedbceef46babde811cec269b4c4','17'),('173aeedbceef46babde811cec269b4c4','17254e99a45f49a097abd2cf041825b8'),('173aeedbceef46babde811cec269b4c4','18'),('173aeedbceef46babde811cec269b4c4','19'),('173aeedbceef46babde811cec269b4c4','1fcad9026fa9415f814f62f962023f85'),('173aeedbceef46babde811cec269b4c4','2'),('173aeedbceef46babde811cec269b4c4','20'),('173aeedbceef46babde811cec269b4c4','20dbc39ef95e49e8a647cfe82f4daa95'),('173aeedbceef46babde811cec269b4c4','21'),('173aeedbceef46babde811cec269b4c4','22'),('173aeedbceef46babde811cec269b4c4','227b128a47fe422e806e453aac974d53'),('173aeedbceef46babde811cec269b4c4','23'),('173aeedbceef46babde811cec269b4c4','24'),('173aeedbceef46babde811cec269b4c4','27'),('173aeedbceef46babde811cec269b4c4','28'),('173aeedbceef46babde811cec269b4c4','29'),('173aeedbceef46babde811cec269b4c4','2df2cd5ca9f9406ab3560a5386af0ea2'),('173aeedbceef46babde811cec269b4c4','2fe057ef51784d73951979f70e5afecc'),('173aeedbceef46babde811cec269b4c4','3'),('173aeedbceef46babde811cec269b4c4','30'),('173aeedbceef46babde811cec269b4c4','31'),('173aeedbceef46babde811cec269b4c4','32'),('173aeedbceef46babde811cec269b4c4','33'),('173aeedbceef46babde811cec269b4c4','34'),('173aeedbceef46babde811cec269b4c4','35'),('173aeedbceef46babde811cec269b4c4','36'),('173aeedbceef46babde811cec269b4c4','37'),('173aeedbceef46babde811cec269b4c4','3732a34c00af43388240ffe4ad8489a3'),('173aeedbceef46babde811cec269b4c4','38'),('173aeedbceef46babde811cec269b4c4','39'),('173aeedbceef46babde811cec269b4c4','3c92c17886944d0687e73e286cada573'),('173aeedbceef46babde811cec269b4c4','3e320999938d44eaaea9c5542e3fa3f6'),('173aeedbceef46babde811cec269b4c4','4'),('173aeedbceef46babde811cec269b4c4','40'),('173aeedbceef46babde811cec269b4c4','41'),('173aeedbceef46babde811cec269b4c4','41bce4d151dd48049a73e440d2a50505'),('173aeedbceef46babde811cec269b4c4','42'),('173aeedbceef46babde811cec269b4c4','43'),('173aeedbceef46babde811cec269b4c4','44'),('173aeedbceef46babde811cec269b4c4','45'),('173aeedbceef46babde811cec269b4c4','46'),('173aeedbceef46babde811cec269b4c4','47'),('173aeedbceef46babde811cec269b4c4','48'),('173aeedbceef46babde811cec269b4c4','4855cf3b25c244fb8500a380db189d97'),('173aeedbceef46babde811cec269b4c4','49'),('173aeedbceef46babde811cec269b4c4','497bf29eb3504019b0a6050c9aa2702d'),('173aeedbceef46babde811cec269b4c4','4bb3f18225ab4de7baa54aae8af6651e'),('173aeedbceef46babde811cec269b4c4','4d1d5051b56e4bcbb0daf603a6d3473d'),('173aeedbceef46babde811cec269b4c4','4e1dd804ed2444dd98919f2eac47d112'),('173aeedbceef46babde811cec269b4c4','4f1a0b9b0fbd48b488c576f4a480b022'),('173aeedbceef46babde811cec269b4c4','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1'),('173aeedbceef46babde811cec269b4c4','5'),('173aeedbceef46babde811cec269b4c4','50'),('173aeedbceef46babde811cec269b4c4','51'),('173aeedbceef46babde811cec269b4c4','51f75adfe8b642518b5ff8b839664b34'),('173aeedbceef46babde811cec269b4c4','52'),('173aeedbceef46babde811cec269b4c4','53'),('173aeedbceef46babde811cec269b4c4','54'),('173aeedbceef46babde811cec269b4c4','55'),('173aeedbceef46babde811cec269b4c4','56'),('173aeedbceef46babde811cec269b4c4','57'),('173aeedbceef46babde811cec269b4c4','58'),('173aeedbceef46babde811cec269b4c4','58d0b78c555c4164ad858c50215e398a'),('173aeedbceef46babde811cec269b4c4','59'),('173aeedbceef46babde811cec269b4c4','5a41b8999b8343239a47d6e8288f90b1'),('173aeedbceef46babde811cec269b4c4','6'),('173aeedbceef46babde811cec269b4c4','60'),('173aeedbceef46babde811cec269b4c4','61'),('173aeedbceef46babde811cec269b4c4','62'),('173aeedbceef46babde811cec269b4c4','63'),('173aeedbceef46babde811cec269b4c4','631a87ca081e4956aeee765f09c21094'),('173aeedbceef46babde811cec269b4c4','64'),('173aeedbceef46babde811cec269b4c4','65'),('173aeedbceef46babde811cec269b4c4','66'),('173aeedbceef46babde811cec269b4c4','67'),('173aeedbceef46babde811cec269b4c4','675b1822b304489bb7571dd6c9aa8183'),('173aeedbceef46babde811cec269b4c4','68'),('173aeedbceef46babde811cec269b4c4','69'),('173aeedbceef46babde811cec269b4c4','695d665d19a34a45928491eef463c177'),('173aeedbceef46babde811cec269b4c4','7'),('173aeedbceef46babde811cec269b4c4','70'),('173aeedbceef46babde811cec269b4c4','7086efa770b3497d967364cafe9c148f'),('173aeedbceef46babde811cec269b4c4','71'),('173aeedbceef46babde811cec269b4c4','72'),('173aeedbceef46babde811cec269b4c4','73'),('173aeedbceef46babde811cec269b4c4','74'),('173aeedbceef46babde811cec269b4c4','79'),('173aeedbceef46babde811cec269b4c4','8'),('173aeedbceef46babde811cec269b4c4','80'),('173aeedbceef46babde811cec269b4c4','81'),('173aeedbceef46babde811cec269b4c4','82'),('173aeedbceef46babde811cec269b4c4','84'),('173aeedbceef46babde811cec269b4c4','88'),('173aeedbceef46babde811cec269b4c4','89'),('173aeedbceef46babde811cec269b4c4','8e30fa7f3ace4180826da9fa6ac4b694'),('173aeedbceef46babde811cec269b4c4','9'),('173aeedbceef46babde811cec269b4c4','90'),('173aeedbceef46babde811cec269b4c4','9d458d0bc2c843ddaf16d63da0dbc689'),('173aeedbceef46babde811cec269b4c4','9fcc920202e7441ba7c8134d02ac0eb0'),('173aeedbceef46babde811cec269b4c4','a032b46de763467d9e5087866a4f5626'),('173aeedbceef46babde811cec269b4c4','a5e0169b98c64494b22ff41fae36828e'),('173aeedbceef46babde811cec269b4c4','a7b33e2abc9a49d69d206f29d73d1d6f'),('173aeedbceef46babde811cec269b4c4','a86dc0f1811744638519a2c8f754ce5c'),('173aeedbceef46babde811cec269b4c4','a8b2d57fbc11499da1a2a19e87afe2a7'),('173aeedbceef46babde811cec269b4c4','a992c9fe83f145fbbaa704ce14a4ef01'),('173aeedbceef46babde811cec269b4c4','ac3ff08440784058b37a6b79826d9fae'),('173aeedbceef46babde811cec269b4c4','afab2db430e2457f9cf3a11feaa8b869'),('173aeedbceef46babde811cec269b4c4','b0e3fbc3e69f4264b96ecae790dcb748'),('173aeedbceef46babde811cec269b4c4','b1f6d1b86ba24365bae7fd86c5082317'),('173aeedbceef46babde811cec269b4c4','b3783d9b71cb46ee925849f3f263e630'),('173aeedbceef46babde811cec269b4c4','ba8092291b40482db8fe7fc006ea3d76'),('173aeedbceef46babde811cec269b4c4','c2e4d9082a0b4386884a0b203afe2c5c'),('173aeedbceef46babde811cec269b4c4','c433fe2b1cee4dc7a09a3c53b9778c0f'),('173aeedbceef46babde811cec269b4c4','c45ed914b6924ed48b1666f243760cae'),('173aeedbceef46babde811cec269b4c4','c54ba9edc75844c3a62e7d03b4ef240c'),('173aeedbceef46babde811cec269b4c4','c96ca6d5d412493aa696d85406a5cad5'),('173aeedbceef46babde811cec269b4c4','cd924730f8fb49519d0de987f3d3c184'),('173aeedbceef46babde811cec269b4c4','d15ec45a4c5449c3bbd7a61d5f9dd1d2'),('173aeedbceef46babde811cec269b4c4','d366e67d0b2c48f9a4591e857b26dd41'),('173aeedbceef46babde811cec269b4c4','dc9069f7ddf4449981bb760f9a9b0f86'),('173aeedbceef46babde811cec269b4c4','df7ce823c5b24ff9bada43d992f373e2'),('173aeedbceef46babde811cec269b4c4','dffa585a19c44b619bc9ba52e83cd532'),('173aeedbceef46babde811cec269b4c4','e031ccc2441045d79f3a1828c46b2989'),('173aeedbceef46babde811cec269b4c4','e39290ba48604010ac67a83f11f1caa6'),('173aeedbceef46babde811cec269b4c4','e42b390a6ba54ebd9ce79c7aa6a544dd'),('173aeedbceef46babde811cec269b4c4','eb98d24431b34608b0534e1d640beea2'),('173aeedbceef46babde811cec269b4c4','fa7e5d84de10402891dae5c0afcb0a08'),('2','1'),('2','10'),('2','11'),('2','12'),('2','13'),('2','14'),('2','15'),('2','16'),('2','17'),('2','18'),('2','19'),('2','2'),('2','20'),('2','21'),('2','22'),('2','23'),('2','24'),('2','27'),('2','28'),('2','29'),('2','3'),('2','30'),('2','31'),('2','32'),('2','33'),('2','34'),('2','35'),('2','36'),('2','37'),('2','38'),('2','39'),('2','4'),('2','40'),('2','41'),('2','42'),('2','43'),('2','44'),('2','45'),('2','46'),('2','47'),('2','48'),('2','49'),('2','5'),('2','50'),('2','51'),('2','52'),('2','53'),('2','54'),('2','55'),('2','56'),('2','57'),('2','58'),('2','59'),('2','6'),('2','60'),('2','61'),('2','62'),('2','63'),('2','64'),('2','65'),('2','66'),('2','67'),('2','68'),('2','69'),('2','7'),('2','70'),('2','71'),('2','72'),('2','73'),('2','74'),('2','79'),('2','8'),('2','80'),('2','81'),('2','82'),('2','84'),('2','85'),('2','88'),('2','89'),('2','9'),('2','90'),('270d3cc4b4f541ff9f3d11bab64bf410','00a7f20428a54a5db62295ecab9f92a4'),('270d3cc4b4f541ff9f3d11bab64bf410','04760cc372044016bfcaa1c363495f8b'),('270d3cc4b4f541ff9f3d11bab64bf410','0b2ebd4d639e4c2b83c2dd0764522f24'),('270d3cc4b4f541ff9f3d11bab64bf410','0ca004d6b1bf4bcab9670a5060d82a55'),('270d3cc4b4f541ff9f3d11bab64bf410','1'),('270d3cc4b4f541ff9f3d11bab64bf410','10'),('270d3cc4b4f541ff9f3d11bab64bf410','11'),('270d3cc4b4f541ff9f3d11bab64bf410','12'),('270d3cc4b4f541ff9f3d11bab64bf410','13'),('270d3cc4b4f541ff9f3d11bab64bf410','14'),('270d3cc4b4f541ff9f3d11bab64bf410','15'),('270d3cc4b4f541ff9f3d11bab64bf410','16'),('270d3cc4b4f541ff9f3d11bab64bf410','17'),('270d3cc4b4f541ff9f3d11bab64bf410','17254e99a45f49a097abd2cf041825b8'),('270d3cc4b4f541ff9f3d11bab64bf410','18'),('270d3cc4b4f541ff9f3d11bab64bf410','19'),('270d3cc4b4f541ff9f3d11bab64bf410','1fcad9026fa9415f814f62f962023f85'),('270d3cc4b4f541ff9f3d11bab64bf410','2'),('270d3cc4b4f541ff9f3d11bab64bf410','20'),('270d3cc4b4f541ff9f3d11bab64bf410','20dbc39ef95e49e8a647cfe82f4daa95'),('270d3cc4b4f541ff9f3d11bab64bf410','21'),('270d3cc4b4f541ff9f3d11bab64bf410','22'),('270d3cc4b4f541ff9f3d11bab64bf410','227b128a47fe422e806e453aac974d53'),('270d3cc4b4f541ff9f3d11bab64bf410','23'),('270d3cc4b4f541ff9f3d11bab64bf410','24'),('270d3cc4b4f541ff9f3d11bab64bf410','27'),('270d3cc4b4f541ff9f3d11bab64bf410','28'),('270d3cc4b4f541ff9f3d11bab64bf410','29'),('270d3cc4b4f541ff9f3d11bab64bf410','2df2cd5ca9f9406ab3560a5386af0ea2'),('270d3cc4b4f541ff9f3d11bab64bf410','2fe057ef51784d73951979f70e5afecc'),('270d3cc4b4f541ff9f3d11bab64bf410','3'),('270d3cc4b4f541ff9f3d11bab64bf410','30'),('270d3cc4b4f541ff9f3d11bab64bf410','31'),('270d3cc4b4f541ff9f3d11bab64bf410','32'),('270d3cc4b4f541ff9f3d11bab64bf410','33'),('270d3cc4b4f541ff9f3d11bab64bf410','34'),('270d3cc4b4f541ff9f3d11bab64bf410','35'),('270d3cc4b4f541ff9f3d11bab64bf410','36'),('270d3cc4b4f541ff9f3d11bab64bf410','37'),('270d3cc4b4f541ff9f3d11bab64bf410','3732a34c00af43388240ffe4ad8489a3'),('270d3cc4b4f541ff9f3d11bab64bf410','38'),('270d3cc4b4f541ff9f3d11bab64bf410','39'),('270d3cc4b4f541ff9f3d11bab64bf410','3c92c17886944d0687e73e286cada573'),('270d3cc4b4f541ff9f3d11bab64bf410','3e320999938d44eaaea9c5542e3fa3f6'),('270d3cc4b4f541ff9f3d11bab64bf410','4'),('270d3cc4b4f541ff9f3d11bab64bf410','40'),('270d3cc4b4f541ff9f3d11bab64bf410','41'),('270d3cc4b4f541ff9f3d11bab64bf410','41bce4d151dd48049a73e440d2a50505'),('270d3cc4b4f541ff9f3d11bab64bf410','42'),('270d3cc4b4f541ff9f3d11bab64bf410','43'),('270d3cc4b4f541ff9f3d11bab64bf410','44'),('270d3cc4b4f541ff9f3d11bab64bf410','45'),('270d3cc4b4f541ff9f3d11bab64bf410','46'),('270d3cc4b4f541ff9f3d11bab64bf410','47'),('270d3cc4b4f541ff9f3d11bab64bf410','48'),('270d3cc4b4f541ff9f3d11bab64bf410','4855cf3b25c244fb8500a380db189d97'),('270d3cc4b4f541ff9f3d11bab64bf410','49'),('270d3cc4b4f541ff9f3d11bab64bf410','497bf29eb3504019b0a6050c9aa2702d'),('270d3cc4b4f541ff9f3d11bab64bf410','4bb3f18225ab4de7baa54aae8af6651e'),('270d3cc4b4f541ff9f3d11bab64bf410','4d1d5051b56e4bcbb0daf603a6d3473d'),('270d3cc4b4f541ff9f3d11bab64bf410','4e1dd804ed2444dd98919f2eac47d112'),('270d3cc4b4f541ff9f3d11bab64bf410','4f1a0b9b0fbd48b488c576f4a480b022'),('270d3cc4b4f541ff9f3d11bab64bf410','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1'),('270d3cc4b4f541ff9f3d11bab64bf410','5'),('270d3cc4b4f541ff9f3d11bab64bf410','50'),('270d3cc4b4f541ff9f3d11bab64bf410','51'),('270d3cc4b4f541ff9f3d11bab64bf410','51f75adfe8b642518b5ff8b839664b34'),('270d3cc4b4f541ff9f3d11bab64bf410','52'),('270d3cc4b4f541ff9f3d11bab64bf410','53'),('270d3cc4b4f541ff9f3d11bab64bf410','54'),('270d3cc4b4f541ff9f3d11bab64bf410','55'),('270d3cc4b4f541ff9f3d11bab64bf410','56'),('270d3cc4b4f541ff9f3d11bab64bf410','57'),('270d3cc4b4f541ff9f3d11bab64bf410','58'),('270d3cc4b4f541ff9f3d11bab64bf410','58d0b78c555c4164ad858c50215e398a'),('270d3cc4b4f541ff9f3d11bab64bf410','59'),('270d3cc4b4f541ff9f3d11bab64bf410','5a41b8999b8343239a47d6e8288f90b1'),('270d3cc4b4f541ff9f3d11bab64bf410','6'),('270d3cc4b4f541ff9f3d11bab64bf410','60'),('270d3cc4b4f541ff9f3d11bab64bf410','61'),('270d3cc4b4f541ff9f3d11bab64bf410','62'),('270d3cc4b4f541ff9f3d11bab64bf410','63'),('270d3cc4b4f541ff9f3d11bab64bf410','631a87ca081e4956aeee765f09c21094'),('270d3cc4b4f541ff9f3d11bab64bf410','64'),('270d3cc4b4f541ff9f3d11bab64bf410','65'),('270d3cc4b4f541ff9f3d11bab64bf410','66'),('270d3cc4b4f541ff9f3d11bab64bf410','67'),('270d3cc4b4f541ff9f3d11bab64bf410','675b1822b304489bb7571dd6c9aa8183'),('270d3cc4b4f541ff9f3d11bab64bf410','68'),('270d3cc4b4f541ff9f3d11bab64bf410','69'),('270d3cc4b4f541ff9f3d11bab64bf410','695d665d19a34a45928491eef463c177'),('270d3cc4b4f541ff9f3d11bab64bf410','7'),('270d3cc4b4f541ff9f3d11bab64bf410','70'),('270d3cc4b4f541ff9f3d11bab64bf410','7086efa770b3497d967364cafe9c148f'),('270d3cc4b4f541ff9f3d11bab64bf410','71'),('270d3cc4b4f541ff9f3d11bab64bf410','72'),('270d3cc4b4f541ff9f3d11bab64bf410','73'),('270d3cc4b4f541ff9f3d11bab64bf410','74'),('270d3cc4b4f541ff9f3d11bab64bf410','79'),('270d3cc4b4f541ff9f3d11bab64bf410','8'),('270d3cc4b4f541ff9f3d11bab64bf410','80'),('270d3cc4b4f541ff9f3d11bab64bf410','81'),('270d3cc4b4f541ff9f3d11bab64bf410','82'),('270d3cc4b4f541ff9f3d11bab64bf410','84'),('270d3cc4b4f541ff9f3d11bab64bf410','88'),('270d3cc4b4f541ff9f3d11bab64bf410','89'),('270d3cc4b4f541ff9f3d11bab64bf410','8e30fa7f3ace4180826da9fa6ac4b694'),('270d3cc4b4f541ff9f3d11bab64bf410','9'),('270d3cc4b4f541ff9f3d11bab64bf410','90'),('270d3cc4b4f541ff9f3d11bab64bf410','9d458d0bc2c843ddaf16d63da0dbc689'),('270d3cc4b4f541ff9f3d11bab64bf410','9fcc920202e7441ba7c8134d02ac0eb0'),('270d3cc4b4f541ff9f3d11bab64bf410','a032b46de763467d9e5087866a4f5626'),('270d3cc4b4f541ff9f3d11bab64bf410','a5e0169b98c64494b22ff41fae36828e'),('270d3cc4b4f541ff9f3d11bab64bf410','a7b33e2abc9a49d69d206f29d73d1d6f'),('270d3cc4b4f541ff9f3d11bab64bf410','a86dc0f1811744638519a2c8f754ce5c'),('270d3cc4b4f541ff9f3d11bab64bf410','a8b2d57fbc11499da1a2a19e87afe2a7'),('270d3cc4b4f541ff9f3d11bab64bf410','a992c9fe83f145fbbaa704ce14a4ef01'),('270d3cc4b4f541ff9f3d11bab64bf410','ac3ff08440784058b37a6b79826d9fae'),('270d3cc4b4f541ff9f3d11bab64bf410','afab2db430e2457f9cf3a11feaa8b869'),('270d3cc4b4f541ff9f3d11bab64bf410','b0e3fbc3e69f4264b96ecae790dcb748'),('270d3cc4b4f541ff9f3d11bab64bf410','b1f6d1b86ba24365bae7fd86c5082317'),('270d3cc4b4f541ff9f3d11bab64bf410','b3783d9b71cb46ee925849f3f263e630'),('270d3cc4b4f541ff9f3d11bab64bf410','ba8092291b40482db8fe7fc006ea3d76'),('270d3cc4b4f541ff9f3d11bab64bf410','c2e4d9082a0b4386884a0b203afe2c5c'),('270d3cc4b4f541ff9f3d11bab64bf410','c433fe2b1cee4dc7a09a3c53b9778c0f'),('270d3cc4b4f541ff9f3d11bab64bf410','c45ed914b6924ed48b1666f243760cae'),('270d3cc4b4f541ff9f3d11bab64bf410','c54ba9edc75844c3a62e7d03b4ef240c'),('270d3cc4b4f541ff9f3d11bab64bf410','c96ca6d5d412493aa696d85406a5cad5'),('270d3cc4b4f541ff9f3d11bab64bf410','cd924730f8fb49519d0de987f3d3c184'),('270d3cc4b4f541ff9f3d11bab64bf410','d15ec45a4c5449c3bbd7a61d5f9dd1d2'),('270d3cc4b4f541ff9f3d11bab64bf410','d366e67d0b2c48f9a4591e857b26dd41'),('270d3cc4b4f541ff9f3d11bab64bf410','dc9069f7ddf4449981bb760f9a9b0f86'),('270d3cc4b4f541ff9f3d11bab64bf410','df7ce823c5b24ff9bada43d992f373e2'),('270d3cc4b4f541ff9f3d11bab64bf410','dffa585a19c44b619bc9ba52e83cd532'),('270d3cc4b4f541ff9f3d11bab64bf410','e031ccc2441045d79f3a1828c46b2989'),('270d3cc4b4f541ff9f3d11bab64bf410','e39290ba48604010ac67a83f11f1caa6'),('270d3cc4b4f541ff9f3d11bab64bf410','e42b390a6ba54ebd9ce79c7aa6a544dd'),('270d3cc4b4f541ff9f3d11bab64bf410','eb98d24431b34608b0534e1d640beea2'),('270d3cc4b4f541ff9f3d11bab64bf410','fa7e5d84de10402891dae5c0afcb0a08'),('3','1'),('3','10'),('3','11'),('3','12'),('3','13'),('3','14'),('3','15'),('3','16'),('3','17'),('3','18'),('3','19'),('3','2'),('3','20'),('3','21'),('3','22'),('3','23'),('3','24'),('3','25'),('3','26'),('3','27'),('3','28'),('3','29'),('3','3'),('3','30'),('3','31'),('3','32'),('3','33'),('3','34'),('3','35'),('3','36'),('3','37'),('3','38'),('3','39'),('3','4'),('3','40'),('3','41'),('3','42'),('3','43'),('3','44'),('3','45'),('3','46'),('3','47'),('3','48'),('3','49'),('3','5'),('3','50'),('3','51'),('3','52'),('3','53'),('3','54'),('3','55'),('3','56'),('3','57'),('3','58'),('3','59'),('3','6'),('3','60'),('3','61'),('3','62'),('3','63'),('3','64'),('3','65'),('3','66'),('3','67'),('3','68'),('3','69'),('3','7'),('3','70'),('3','71'),('3','72'),('3','73'),('3','74'),('3','75'),('3','76'),('3','77'),('3','78'),('3','79'),('3','8'),('3','80'),('3','81'),('3','82'),('3','83'),('3','84'),('3','85'),('3','86'),('3','87'),('3','88'),('3','89'),('3','9'),('3','90'),('33939fa3a4f7412994f266c3bd5333a1','06a90404e55b4d338d4a1a1cb5c74f27'),('33939fa3a4f7412994f266c3bd5333a1','0d39f13b0bce4d2f8d5eb6ab0ab4b1dd'),('33939fa3a4f7412994f266c3bd5333a1','1'),('33939fa3a4f7412994f266c3bd5333a1','20c759ed5e1e4cd282c64582b416ca6d'),('33939fa3a4f7412994f266c3bd5333a1','26dcc4bd31aa4e4bbaffee152373c34d'),('33939fa3a4f7412994f266c3bd5333a1','360d2d2aed524a69aedf8af24ed38f80'),('33939fa3a4f7412994f266c3bd5333a1','42f523bc3bc24c93b1d7a3fd41fd571f'),('33939fa3a4f7412994f266c3bd5333a1','4eda72acbd5e40f2aec352c48306a47d'),('33939fa3a4f7412994f266c3bd5333a1','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1'),('33939fa3a4f7412994f266c3bd5333a1','919526a9417044788af085d864801794'),('33939fa3a4f7412994f266c3bd5333a1','9c2989e7c81d4c31a71074c608f99cd1'),('33939fa3a4f7412994f266c3bd5333a1','a46cce6cb1c74f4eb247cfdcf6691a15'),('33939fa3a4f7412994f266c3bd5333a1','ba99e66660934a6098c33422ddb85fa0'),('33939fa3a4f7412994f266c3bd5333a1','c1621d7d063a42059c402732fb719be7'),('33939fa3a4f7412994f266c3bd5333a1','cc1b8e6afbcc49478e0f41030c05e552'),('33939fa3a4f7412994f266c3bd5333a1','e381f83ea3b84693bf93ba1ba6a75b16'),('33939fa3a4f7412994f266c3bd5333a1','eede912f457c4ac790abe7e950a28e57'),('33939fa3a4f7412994f266c3bd5333a1','fba8bce2118f4f3f84cf16b1f485d1f7'),('33939fa3a4f7412994f266c3bd5333a1','fdba81d4efec45c6bdd9e3a72427a50b'),('47cd9f09fd0c467392921ee1340d749d','00a7f20428a54a5db62295ecab9f92a4'),('47cd9f09fd0c467392921ee1340d749d','04760cc372044016bfcaa1c363495f8b'),('47cd9f09fd0c467392921ee1340d749d','0b2ebd4d639e4c2b83c2dd0764522f24'),('47cd9f09fd0c467392921ee1340d749d','0ca004d6b1bf4bcab9670a5060d82a55'),('47cd9f09fd0c467392921ee1340d749d','1'),('47cd9f09fd0c467392921ee1340d749d','10'),('47cd9f09fd0c467392921ee1340d749d','11'),('47cd9f09fd0c467392921ee1340d749d','12'),('47cd9f09fd0c467392921ee1340d749d','13'),('47cd9f09fd0c467392921ee1340d749d','14'),('47cd9f09fd0c467392921ee1340d749d','15'),('47cd9f09fd0c467392921ee1340d749d','16'),('47cd9f09fd0c467392921ee1340d749d','17'),('47cd9f09fd0c467392921ee1340d749d','17254e99a45f49a097abd2cf041825b8'),('47cd9f09fd0c467392921ee1340d749d','18'),('47cd9f09fd0c467392921ee1340d749d','19'),('47cd9f09fd0c467392921ee1340d749d','1fcad9026fa9415f814f62f962023f85'),('47cd9f09fd0c467392921ee1340d749d','2'),('47cd9f09fd0c467392921ee1340d749d','20'),('47cd9f09fd0c467392921ee1340d749d','20dbc39ef95e49e8a647cfe82f4daa95'),('47cd9f09fd0c467392921ee1340d749d','21'),('47cd9f09fd0c467392921ee1340d749d','22'),('47cd9f09fd0c467392921ee1340d749d','227b128a47fe422e806e453aac974d53'),('47cd9f09fd0c467392921ee1340d749d','23'),('47cd9f09fd0c467392921ee1340d749d','24'),('47cd9f09fd0c467392921ee1340d749d','27'),('47cd9f09fd0c467392921ee1340d749d','28'),('47cd9f09fd0c467392921ee1340d749d','29'),('47cd9f09fd0c467392921ee1340d749d','2df2cd5ca9f9406ab3560a5386af0ea2'),('47cd9f09fd0c467392921ee1340d749d','2fe057ef51784d73951979f70e5afecc'),('47cd9f09fd0c467392921ee1340d749d','3'),('47cd9f09fd0c467392921ee1340d749d','30'),('47cd9f09fd0c467392921ee1340d749d','31'),('47cd9f09fd0c467392921ee1340d749d','32'),('47cd9f09fd0c467392921ee1340d749d','33'),('47cd9f09fd0c467392921ee1340d749d','34'),('47cd9f09fd0c467392921ee1340d749d','35'),('47cd9f09fd0c467392921ee1340d749d','36'),('47cd9f09fd0c467392921ee1340d749d','37'),('47cd9f09fd0c467392921ee1340d749d','3732a34c00af43388240ffe4ad8489a3'),('47cd9f09fd0c467392921ee1340d749d','38'),('47cd9f09fd0c467392921ee1340d749d','39'),('47cd9f09fd0c467392921ee1340d749d','3c92c17886944d0687e73e286cada573'),('47cd9f09fd0c467392921ee1340d749d','3e320999938d44eaaea9c5542e3fa3f6'),('47cd9f09fd0c467392921ee1340d749d','4'),('47cd9f09fd0c467392921ee1340d749d','40'),('47cd9f09fd0c467392921ee1340d749d','41'),('47cd9f09fd0c467392921ee1340d749d','41bce4d151dd48049a73e440d2a50505'),('47cd9f09fd0c467392921ee1340d749d','42'),('47cd9f09fd0c467392921ee1340d749d','43'),('47cd9f09fd0c467392921ee1340d749d','44'),('47cd9f09fd0c467392921ee1340d749d','45'),('47cd9f09fd0c467392921ee1340d749d','46'),('47cd9f09fd0c467392921ee1340d749d','47'),('47cd9f09fd0c467392921ee1340d749d','48'),('47cd9f09fd0c467392921ee1340d749d','4855cf3b25c244fb8500a380db189d97'),('47cd9f09fd0c467392921ee1340d749d','49'),('47cd9f09fd0c467392921ee1340d749d','497bf29eb3504019b0a6050c9aa2702d'),('47cd9f09fd0c467392921ee1340d749d','4bb3f18225ab4de7baa54aae8af6651e'),('47cd9f09fd0c467392921ee1340d749d','4d1d5051b56e4bcbb0daf603a6d3473d'),('47cd9f09fd0c467392921ee1340d749d','4e1dd804ed2444dd98919f2eac47d112'),('47cd9f09fd0c467392921ee1340d749d','4f1a0b9b0fbd48b488c576f4a480b022'),('47cd9f09fd0c467392921ee1340d749d','4f7c8f4e7e4a4a2a9e02e8a66d6c4ca1'),('47cd9f09fd0c467392921ee1340d749d','5'),('47cd9f09fd0c467392921ee1340d749d','50'),('47cd9f09fd0c467392921ee1340d749d','51'),('47cd9f09fd0c467392921ee1340d749d','51f75adfe8b642518b5ff8b839664b34'),('47cd9f09fd0c467392921ee1340d749d','52'),('47cd9f09fd0c467392921ee1340d749d','53'),('47cd9f09fd0c467392921ee1340d749d','54'),('47cd9f09fd0c467392921ee1340d749d','55'),('47cd9f09fd0c467392921ee1340d749d','56'),('47cd9f09fd0c467392921ee1340d749d','57'),('47cd9f09fd0c467392921ee1340d749d','58'),('47cd9f09fd0c467392921ee1340d749d','58d0b78c555c4164ad858c50215e398a'),('47cd9f09fd0c467392921ee1340d749d','59'),('47cd9f09fd0c467392921ee1340d749d','5a41b8999b8343239a47d6e8288f90b1'),('47cd9f09fd0c467392921ee1340d749d','6'),('47cd9f09fd0c467392921ee1340d749d','60'),('47cd9f09fd0c467392921ee1340d749d','61'),('47cd9f09fd0c467392921ee1340d749d','62'),('47cd9f09fd0c467392921ee1340d749d','63'),('47cd9f09fd0c467392921ee1340d749d','631a87ca081e4956aeee765f09c21094'),('47cd9f09fd0c467392921ee1340d749d','64'),('47cd9f09fd0c467392921ee1340d749d','65'),('47cd9f09fd0c467392921ee1340d749d','66'),('47cd9f09fd0c467392921ee1340d749d','67'),('47cd9f09fd0c467392921ee1340d749d','675b1822b304489bb7571dd6c9aa8183'),('47cd9f09fd0c467392921ee1340d749d','68'),('47cd9f09fd0c467392921ee1340d749d','69'),('47cd9f09fd0c467392921ee1340d749d','695d665d19a34a45928491eef463c177'),('47cd9f09fd0c467392921ee1340d749d','7'),('47cd9f09fd0c467392921ee1340d749d','70'),('47cd9f09fd0c467392921ee1340d749d','7086efa770b3497d967364cafe9c148f'),('47cd9f09fd0c467392921ee1340d749d','71'),('47cd9f09fd0c467392921ee1340d749d','72'),('47cd9f09fd0c467392921ee1340d749d','73'),('47cd9f09fd0c467392921ee1340d749d','74'),('47cd9f09fd0c467392921ee1340d749d','79'),('47cd9f09fd0c467392921ee1340d749d','8'),('47cd9f09fd0c467392921ee1340d749d','80'),('47cd9f09fd0c467392921ee1340d749d','81'),('47cd9f09fd0c467392921ee1340d749d','82'),('47cd9f09fd0c467392921ee1340d749d','84'),('47cd9f09fd0c467392921ee1340d749d','88'),('47cd9f09fd0c467392921ee1340d749d','89'),('47cd9f09fd0c467392921ee1340d749d','8e30fa7f3ace4180826da9fa6ac4b694'),('47cd9f09fd0c467392921ee1340d749d','9'),('47cd9f09fd0c467392921ee1340d749d','90'),('47cd9f09fd0c467392921ee1340d749d','9d458d0bc2c843ddaf16d63da0dbc689'),('47cd9f09fd0c467392921ee1340d749d','9fcc920202e7441ba7c8134d02ac0eb0'),('47cd9f09fd0c467392921ee1340d749d','a032b46de763467d9e5087866a4f5626'),('47cd9f09fd0c467392921ee1340d749d','a5e0169b98c64494b22ff41fae36828e'),('47cd9f09fd0c467392921ee1340d749d','a7b33e2abc9a49d69d206f29d73d1d6f'),('47cd9f09fd0c467392921ee1340d749d','a86dc0f1811744638519a2c8f754ce5c'),('47cd9f09fd0c467392921ee1340d749d','a8b2d57fbc11499da1a2a19e87afe2a7'),('47cd9f09fd0c467392921ee1340d749d','a992c9fe83f145fbbaa704ce14a4ef01'),('47cd9f09fd0c467392921ee1340d749d','ac3ff08440784058b37a6b79826d9fae'),('47cd9f09fd0c467392921ee1340d749d','afab2db430e2457f9cf3a11feaa8b869'),('47cd9f09fd0c467392921ee1340d749d','b0e3fbc3e69f4264b96ecae790dcb748'),('47cd9f09fd0c467392921ee1340d749d','b1f6d1b86ba24365bae7fd86c5082317'),('47cd9f09fd0c467392921ee1340d749d','b3783d9b71cb46ee925849f3f263e630'),('47cd9f09fd0c467392921ee1340d749d','ba8092291b40482db8fe7fc006ea3d76'),('47cd9f09fd0c467392921ee1340d749d','c2e4d9082a0b4386884a0b203afe2c5c'),('47cd9f09fd0c467392921ee1340d749d','c433fe2b1cee4dc7a09a3c53b9778c0f'),('47cd9f09fd0c467392921ee1340d749d','c45ed914b6924ed48b1666f243760cae'),('47cd9f09fd0c467392921ee1340d749d','c54ba9edc75844c3a62e7d03b4ef240c'),('47cd9f09fd0c467392921ee1340d749d','c96ca6d5d412493aa696d85406a5cad5'),('47cd9f09fd0c467392921ee1340d749d','cd924730f8fb49519d0de987f3d3c184'),('47cd9f09fd0c467392921ee1340d749d','d15ec45a4c5449c3bbd7a61d5f9dd1d2'),('47cd9f09fd0c467392921ee1340d749d','d366e67d0b2c48f9a4591e857b26dd41'),('47cd9f09fd0c467392921ee1340d749d','dc9069f7ddf4449981bb760f9a9b0f86'),('47cd9f09fd0c467392921ee1340d749d','df7ce823c5b24ff9bada43d992f373e2'),('47cd9f09fd0c467392921ee1340d749d','dffa585a19c44b619bc9ba52e83cd532'),('47cd9f09fd0c467392921ee1340d749d','e031ccc2441045d79f3a1828c46b2989'),('47cd9f09fd0c467392921ee1340d749d','e39290ba48604010ac67a83f11f1caa6'),('47cd9f09fd0c467392921ee1340d749d','e42b390a6ba54ebd9ce79c7aa6a544dd'),('47cd9f09fd0c467392921ee1340d749d','eb98d24431b34608b0534e1d640beea2'),('47cd9f09fd0c467392921ee1340d749d','fa7e5d84de10402891dae5c0afcb0a08'),('6','1'),('6','27'),('6','28'),('6','29'),('6','30'),('6','56'),('6','57'),('6','71');

/*Table structure for table `sys_role_office` */

DROP TABLE IF EXISTS `sys_role_office`;

CREATE TABLE `sys_role_office` (
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色-机构';

/*Data for the table `sys_role_office` */

insert  into `sys_role_office`(`role_id`,`office_id`) values ('7','10'),('7','11'),('7','12'),('7','13'),('7','14'),('7','15'),('7','16'),('7','17'),('7','18'),('7','19'),('7','20'),('7','21'),('7','22'),('7','23'),('7','24'),('7','25'),('7','26'),('7','7'),('7','8'),('7','9');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `company_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '登录名',
  `password` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `cdboo_password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `business_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `no` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '工号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `user_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户表';

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`company_id`,`office_id`,`login_name`,`password`,`cdboo_password`,`business_id`,`no`,`name`,`email`,`phone`,`mobile`,`user_type`,`photo`,`login_ip`,`login_date`,`login_flag`,`create_by`,`create_date`,`update_by`,`update_date`,`remarks`,`del_flag`) values ('0a7049b6dc02464989ceaf0f64860913','0954b5e7d8484a1c83716e580b6c3e0b','b0106380dbc34bb5920b29a85d818749','hy','ac7b2f9de79813bdeb5260ef3c0e426916c338501f54722e432a246d',NULL,NULL,'002','侯佚','','','','3','',NULL,NULL,'1','1','2016-12-22 10:40:32','1','2016-12-22 10:40:32','','0'),('1','1','2','thinkgem','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','827ccb0eea8a706c4c34a16891f84e7b',NULL,'0001','系统管理员','thinkgem@163.com','8675','8675',NULL,NULL,'0:0:0:0:0:0:0:1','2017-01-16 08:41:35','1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00','最高管理员','0'),('10','86b3334b98c742909e09c86f40404070','e14a7b00f5b74aaea989e5f5e724dfed','ccsgly','705602f44e46134a5966f7600b77c6f7dcf36962b4d1743e03513c3e',NULL,NULL,'0010','长春市管理员','','','','1','',NULL,NULL,'1','1','2013-05-27 08:00:00','1','2016-10-08 14:14:42','','1'),('11','12','13','lc_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0011','济南历城领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('115e96c89a5c444e9ef0bfdefc4c4619','11312930c669486081381cc4da7018e7','206b97292c824421b0e32a36fb9ba374','yb','40e871b01acc3f58df07c02c00bbafbdb0ea08fbed44cc7d6502b17d',NULL,NULL,'001','于滨','','13111111111','13111111111','3','/cdboo/userfiles/1/images/photo/2017/01/96671895140199174.jpg','218.67.189.146','2017-01-15 23:25:26','1','1','2016-12-22 10:39:39','1','2017-01-15 23:25:20','','0'),('12','12','18','lx_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0012','济南历下领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('13','22','23','gx_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0013','济南高新领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('1c030b8a00a54718987b502c7bff3a3b','1','2','eeeee','4ced931c4b33079f1356c66b449dc17a4a7ae8cd040590f0431fe16f',NULL,'b18a16c32a8446e3afe50a8789238159','eeeee','eeeee','','','','','',NULL,NULL,'1','1','2016-12-30 16:37:00','1','2016-12-30 16:37:00','','0'),('2','1','2','sd_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0002','管理员',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('28d082bfd7cd4edc9501ed842fbdd59c','1','2','ooooo','87870ebd71431b9021dbe760dbaa1d50908999ddb9b42a7dcd1376e3',NULL,'b18a16c32a8446e3afe50a8789238159','ooooo','ooooo','','','','','',NULL,NULL,'1','1','2016-12-30 16:50:21','1','2016-12-30 16:50:21','','0'),('29d0109c50c144bbbd202f0c4c0a473a','1','2','tttttt','0c83bd35e362e0623fb0c6476f325c6a65f0a3d756d2d251811fd879',NULL,'b18a16c32a8446e3afe50a8789238159','tttttt','ttttt','','','','','',NULL,NULL,'1','1','2016-12-30 15:20:27','1','2016-12-30 15:20:27','','0'),('2c2e07fee8ba4885a5cb03dbcf333251','1','2','test113','da563ff7a98e5969675e0eb9d34ff2c1b002b1178cc4a72e4ca46c0a',NULL,'b18a16c32a8446e3afe50a8789238159','113','test113','','','','3','',NULL,NULL,'1','1','2016-12-30 15:51:06','1','2016-12-30 15:51:06','','0'),('3','1','3','sd_zhb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0003','综合部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('4','1','4','sd_scb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0004','市场部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('5','1','5','sd_jsb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0005','技术部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('6','1','6','sd_yfb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032',NULL,NULL,'0006','研发部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1','2013-05-27 08:00:00','1','2013-05-27 08:00:00',NULL,'1'),('69222a5dd02146efab0c8d1b9ffb40ff','1','2','8888','b58ec7e10cd8c31d70d575b5a16ff6fdbf8bce4e3c4e90afb2b6a738',NULL,'c336c68038954abb99852eb3cfd29f67','8888','8888','','','','','',NULL,NULL,'1','1','2016-12-30 14:47:30','1','2016-12-30 14:47:30','','0'),('7','7','8','lnsgly','e1dc1140f25acfbe8b88739934313c4fccd76ee4180b93243dae4454',NULL,NULL,'0007','辽宁省管理员','','','','1','',NULL,NULL,'1','1','2013-05-27 08:00:00','1','2016-10-08 14:11:45','','1'),('754045126b554e598a1f8ff7c60f2b42','1','2','66666','760703edf62ae710d18baa94abb532c08ad51d36f6ecf86e67e3617f',NULL,'c336c68038954abb99852eb3cfd29f67','66666','66666','','','','','',NULL,NULL,'1','1','2016-12-30 14:52:14','1','2016-12-30 14:52:14','','0'),('8','12','c7da93b87243499b8691279b64aee7c9','sysgly','82ccad37489f50824b5b1828fa4c6fa13636eae3a55c8ee1fbc34e42',NULL,NULL,'0008','沈阳市管理员','','','','1','',NULL,NULL,'1','1','2013-05-27 08:00:00','1','2016-10-08 14:12:56','','1'),('8b65e8fbb02143428fc94e79a170724e','1','2','iiiii','1c8dfe96bb301ced00b0de19dbb057f9243e8533b7ac008cca3ae45f',NULL,'b18a16c32a8446e3afe50a8789238159','iiiii','iiiii','','','','','',NULL,NULL,'1','1','2016-12-30 16:42:34','1','2016-12-30 16:42:34','','0'),('9','fb2703e6dd1c493591a19f8dd7170027','0acd4c2f5fe142258edd4ab5ffe6ad5b','jlsgly','b40569dee73a0df105711feaf9b9c9e3292ddf784292346538969eac',NULL,NULL,'0009','吉林省管理员','','','','3','',NULL,NULL,'1','1','2013-05-27 08:00:00','1','2016-12-22 10:07:37','','1'),('90c97ba31ae44692b9f8c435b9abd8d2','1','2','uuuuu','e5bbda757c7e67da3361d58f7d6ba3955d9c245c5123d88c07b4b1c4',NULL,'b18a16c32a8446e3afe50a8789238159','uuuuu','uuuuu','','','','','',NULL,NULL,'1','1','2016-12-30 16:04:47','1','2016-12-30 16:04:47','','0'),('9beb4919b62e4c8d9a91efc358026f8d','1','206b97292c824421b0e32a36fb9ba374','test11','ba8ea5f675706a00088f4850fbc5352fe127192c783b87d6eb966d85',NULL,'df0da91cf5964d7a8a79b531ee9e718e','111','test11','','','','3','',NULL,NULL,'1','1','2016-12-30 15:48:14','1','2016-12-30 15:48:14','','0'),('bc0958bb3def433e94a15f234fa4cdf4','1','2','55555','e10805965adf991141a13681b200f025e2babbcc75245e0ecdb72e0f',NULL,'c336c68038954abb99852eb3cfd29f67','555','555','','','','','',NULL,NULL,'1','1','2016-12-30 14:45:11','1','2016-12-30 14:45:11','','0'),('c46a8ba214834ce09d5de2dcc67f35cf','1','2','99999','617742ff9f9ef5cefe7360f97f047b888bb5845411cf93cd926fbd8e',NULL,'c336c68038954abb99852eb3cfd29f67','99999','99999','','','','','',NULL,NULL,'1','1','2016-12-30 14:50:25','1','2016-12-30 14:50:25','','0'),('c7104620e77443c3afa32bbb25f22337','1','2','fudd','f0b9ba38bc5995bd00e8848d35818b1e6527b39e54634318b61a80fc',NULL,NULL,'001','111','','','','1','','127.0.0.1','2016-06-02 11:22:46','1','1','2016-06-02 10:45:28','1','2016-06-02 10:45:28','','1'),('ca72ecae34b141bd8a4997249365e536','1','2','1111111','20e5b889254ec7ba8b1d65883775662513b30b3e81ac152a9adb0735',NULL,'c336c68038954abb99852eb3cfd29f67','11111','1111111','','','','','',NULL,NULL,'1','1','2016-12-30 14:39:33','1','2016-12-30 14:39:33','','0'),('ced81600c4da48aeb7fa20e758481bf2','1','2','test112','0586e1e0293ba8651b7b5ad2467f1fb68585c24eeb9e0c9a0301227f',NULL,'95c241c972b142649bbd22745e7d7068','112','test112','','','','3','',NULL,NULL,'1','1','2016-12-30 15:49:25','1','2016-12-30 15:49:25','','0'),('d7a2c0eb43964380812f1481a39d99a5','1','2','aaaaa','8762f950074f66b657d614793a96ff041622b525ec92f4a8f0e1905f',NULL,'b18a16c32a8446e3afe50a8789238159','aaaaa','aaaaa','','','','','',NULL,NULL,'1','1','2016-12-30 14:55:07','1','2016-12-30 14:55:07','','0'),('da11a99d81ec4a5eaf845de984fcf414','1','2','test000','8eecf32e5d2a6dae6f2c21206a97e461e7c9076b87541b8ae87f4c09',NULL,'b18a16c32a8446e3afe50a8789238159','000','000','','','','','',NULL,NULL,'1','1','2016-12-30 11:39:37','1','2016-12-31 09:53:26','','0'),('e1cf42e3c637495e92108a6e0f80f371','11312930c669486081381cc4da7018e7','206b97292c824421b0e32a36fb9ba374','zgc','dc255218ca55717b61999e7485ca25c36d7fa6dbcd7ae93dc239d4c4',NULL,NULL,'003','朱广成','','','','3','',NULL,NULL,'1','1','2016-12-22 10:41:03','1','2016-12-22 10:41:15','','0'),('f2f58465f54e4b3cb712734ab2ffff36','1','2','wwwww','2171170d6d869057a85e3961257c80d6abd8413ed68940365e6c4783',NULL,'b18a16c32a8446e3afe50a8789238159','wwwww','wwwww','','','','','',NULL,NULL,'1','1','2016-12-30 16:45:35','1','2016-12-30 16:45:35','','0');

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户-角色';

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`user_id`,`role_id`) values ('0a7049b6dc02464989ceaf0f64860913','33939fa3a4f7412994f266c3bd5333a1'),('1','1'),('1','2'),('10','173aeedbceef46babde811cec269b4c4'),('11','3'),('115e96c89a5c444e9ef0bfdefc4c4619','33939fa3a4f7412994f266c3bd5333a1'),('12','4'),('13','5'),('14','6'),('1c030b8a00a54718987b502c7bff3a3b','1'),('2','1'),('28d082bfd7cd4edc9501ed842fbdd59c','1'),('29d0109c50c144bbbd202f0c4c0a473a','1'),('2c2e07fee8ba4885a5cb03dbcf333251','33939fa3a4f7412994f266c3bd5333a1'),('3','2'),('4','3'),('5','4'),('6','5'),('69222a5dd02146efab0c8d1b9ffb40ff','1'),('7','270d3cc4b4f541ff9f3d11bab64bf410'),('754045126b554e598a1f8ff7c60f2b42','1'),('8','47cd9f09fd0c467392921ee1340d749d'),('8b65e8fbb02143428fc94e79a170724e','1'),('9','1'),('9','2'),('90c97ba31ae44692b9f8c435b9abd8d2','1'),('9beb4919b62e4c8d9a91efc358026f8d','33939fa3a4f7412994f266c3bd5333a1'),('bc0958bb3def433e94a15f234fa4cdf4','1'),('c46a8ba214834ce09d5de2dcc67f35cf','1'),('c7104620e77443c3afa32bbb25f22337','6'),('ca72ecae34b141bd8a4997249365e536','1'),('ced81600c4da48aeb7fa20e758481bf2','33939fa3a4f7412994f266c3bd5333a1'),('d7a2c0eb43964380812f1481a39d99a5','1'),('da11a99d81ec4a5eaf845de984fcf414','33939fa3a4f7412994f266c3bd5333a1'),('e1cf42e3c637495e92108a6e0f80f371','33939fa3a4f7412994f266c3bd5333a1'),('f2f58465f54e4b3cb712734ab2ffff36','1');

/*Table structure for table `tal_user` */

DROP TABLE IF EXISTS `tal_user`;

CREATE TABLE `tal_user` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `login_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '登录名',
  `password` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `nickname` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '昵称',
  `token` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'token',
  `email` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '手机',
  `user_type` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '用户类型',
  `photo` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '用户头像',
  `login_ip` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `login_flag` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可登录',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='终端用户注册表';

/*Data for the table `tal_user` */

/*Table structure for table `test_data` */

DROP TABLE IF EXISTS `test_data`;

CREATE TABLE `test_data` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `sex` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务数据表';

/*Data for the table `test_data` */

/*Table structure for table `test_data_child` */

DROP TABLE IF EXISTS `test_data_child`;

CREATE TABLE `test_data_child` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `test_data_main_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '业务主表ID',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_child_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务数据子表';

/*Data for the table `test_data_child` */

/*Table structure for table `test_data_main` */

DROP TABLE IF EXISTS `test_data_main`;

CREATE TABLE `test_data_main` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `user_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属用户',
  `office_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属部门',
  `area_id` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '归属区域',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `sex` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
  `in_date` date DEFAULT NULL COMMENT '加入日期',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_data_main_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务数据表';

/*Data for the table `test_data_main` */

/*Table structure for table `test_tree` */

DROP TABLE IF EXISTS `test_tree`;

CREATE TABLE `test_tree` (
  `id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `parent_id` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `sort` decimal(10,0) NOT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `test_tree_del_flag` (`del_flag`),
  KEY `test_data_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='树结构表';

/*Data for the table `test_tree` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;