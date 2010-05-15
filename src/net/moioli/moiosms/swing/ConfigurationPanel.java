/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * ConfigurationPanel.java
 *
 * Created on Apr 30, 2010, 10:15:17 PM
 */

package net.moioli.moiosms.swing;

import java.util.Map;
import java.util.TreeMap;

/**
 *
 * @author silvio
 */
public class ConfigurationPanel extends javax.swing.JPanel {

    /** Creates new form ConfigurationPanel */
    public ConfigurationPanel(String text, ConfigurationPairPanel[] panels) {
        this.text = text;
        this.panels = panels;
        initComponents();
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jPanel1 = new javax.swing.JPanel();

        setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText(text);

        jPanel1.setLayout(new java.awt.GridLayout(1, panels.length));
        for (ConfigurationPairPanel panel: panels){
            jPanel1.add(panel);
        }

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 215, Short.MAX_VALUE)
            .add(jLabel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 215, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 22, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 21, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    public String getText(){
        return text;
    }

    public Map<String,String> getMap(){
        Map<String,String> result = new TreeMap<String,String>();

        for(ConfigurationPairPanel panel:panels){
            result.put(panel.getText(), panel.getValue());
        }

        return result;
    }

    private String text;
    private ConfigurationPairPanel[] panels;

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    // End of variables declaration//GEN-END:variables

}